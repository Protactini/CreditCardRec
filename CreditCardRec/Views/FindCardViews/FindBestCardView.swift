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
    @State private var selectedAreas: [CashBackArea] = CashBackArea.allCases
    
    // Namespace for matched‐geometry effects between the bar and overlay
    @Namespace private var animation
    @Namespace private var searchBar

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: Search Bar
                HStack {
                    // 1) The scrollable row of pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            if !selectedAreas.isEmpty {
                                ForEach(selectedAreas, id:\.self) { area in
                                    Text(area.rawValue)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(.systemGray6))
                                        )
                                        // remove pill when touvhed
                                        .onTapGesture {
                                            if expandSearch {
                                                withAnimation(.spring()) {
                                                    if let idx = selectedAreas.firstIndex(of: area) {
                                                        selectedAreas.remove(at: idx)
                                                    }
                                                }
                                            }
                                        }
                                    
                                        .matchedGeometryEffect(id: area.rawValue, in: animation)
                                }
                            } else {
                                Text("Choose a category…")
                                    .foregroundColor(.gray)
                                    .matchedGeometryEffect(id: searchBar, in: animation)
                            }
                        }
                        .padding(.horizontal, 4)   // inner padding for scroll content
                    }
                    .frame(height: 44)            // fixed height for the box
                    .matchedGeometryEffect(id: searchBar, in: animation)
                    
                    Spacer()
                    
                    if expandSearch {
                        Button("OK") {
                            // Sort cards by selectedArea’s cash back desc
                            //                            if let sel = selectedArea {
                            //                                cardsList.sort {
                            //                                    let lhs = $0.cashBack?.first { $0.area == sel }?.percentage ?? 0
                            //                                    let rhs = $1.cashBack?.first { $0.area == sel }?.percentage ?? 0
                            //                                    return lhs > rhs
                            //                                }
                            //                            }
                            withAnimation(.spring()) {
                                expandSearch = false
                            }
                        }
                        .padding(.horizontal)
                        .debugBorder(DebugConfig.color(at: 2))
                    }
                }
                .padding()                        // outer padding
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding()                        // match your previous style
                .contentShape(Rectangle())
                .onTapGesture {
                    if !expandSearch{
                        withAnimation(.spring()) {
                            expandSearch = true
                        }
                    }
                }
                .debugBorder(DebugConfig.color(at: 2))
                

                ZStack{
                    // MARK: Card List
                    if !expandSearch {
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
                        .zIndex(0)
                    }
                    
                    // MARK: Search Overlay
                    if expandSearch {
                        // Grid of all areas
                        let columns = [GridItem(.adaptive(minimum: 80), spacing: 16)]
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(CashBackArea.allCases) { area in
                                if !selectedAreas.contains(area){
                                    Text(area.rawValue)
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(.systemGray5))
                                        )
                                        .foregroundColor(.primary)
                                        .onTapGesture {
                                            withAnimation(.spring()) {
                                                selectedAreas.append(area)
                                            }
                                        }
        //                                    .opacity(area == selectedArea ? 0 : 1)
                                        .matchedGeometryEffect(id: area.rawValue, in: animation, isSource: true)
                                        .debugBorder(DebugConfig.color(at: 3))
                                }
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                        .background(Color(.systemBackground).ignoresSafeArea())
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .zIndex(1)
                        
                    }
                }
            }
        }
    }
}

struct FindBestCardView_Previews: PreviewProvider {
    static var previews: some View {
        FindBestCardView()
    }
}
