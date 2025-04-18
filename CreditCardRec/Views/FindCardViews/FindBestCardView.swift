//
//  FindBestCardView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct FindBestCardView: View {
    // All cards to choose from
    @State private var cardsList: [Card] = cards
    
    // Controls whether the search overlay is showing
    @State private var expandSearch = false
    
    // The area selected in the search overlay
    @State private var selectedArea: CashBackArea? = nil
    
    // Namespace for matched‐geometry effects between the bar and overlay
    @Namespace private var animation

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: Search Bar
                HStack {
                    if let area = selectedArea {
                        // Show the selected area as a pill
                        Text(area.rawValue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray6))
                                    .matchedGeometryEffect(id: area.rawValue, in: animation)
                            )
                    } else {
                        Text("Select category…")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        expandSearch = true
                    }
                }
                .padding()

                // MARK: Card List
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(cardsList) { card in
                            CardView(expandCards: .constant(true), card: card) {
                                /* no-op */
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .zIndex(0)

            // MARK: Search Overlay
            if expandSearch {
                VStack {
                    // Top bar with matched pill and OK button
                    HStack {
                        if let area = selectedArea {
                            Text(area.rawValue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray6))
                                        .matchedGeometryEffect(id: area.rawValue, in: animation)
                                )
                        } else {
                            Text("Choose a category")
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        Button("OK") {
                            // Sort cards by selectedArea’s cash back desc
                            if let sel = selectedArea {
                                cardsList.sort {
                                    let lhs = $0.cashBack?.first { $0.area == sel }?.percentage ?? 0
                                    let rhs = $1.cashBack?.first { $0.area == sel }?.percentage ?? 0
                                    return lhs > rhs
                                }
                            }
                            withAnimation(.spring()) {
                                expandSearch = false
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    
                    // Grid of all areas
                    let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(CashBackArea.allCases) { area in
                            Text(area.rawValue)
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(selectedArea == area ? Color.blue : Color(.systemGray5))
                                )
                                .foregroundColor(selectedArea == area ? .white : .primary)
                                .matchedGeometryEffect(id: area.rawValue, in: animation)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        selectedArea = area
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    
                    Spacer()
                }
                .background(Color(.systemBackground).ignoresSafeArea())
                .transition(.opacity.combined(with: .move(edge: .top)))
                .zIndex(1)
            }
        }
    }
}

struct FindBestCardView_Previews: PreviewProvider {
    static var previews: some View {
        FindBestCardView()
    }
}
