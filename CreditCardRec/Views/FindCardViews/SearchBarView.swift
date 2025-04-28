//
//  SearchBarView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/28/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var expandSearch: Bool
    @Binding var selectedAreas: [CashBackArea]
    var animation: Namespace.ID

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if !selectedAreas.isEmpty {
                        ForEach(selectedAreas, id: \ .self) { area in
                            Text(area.rawValue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray6))
                                )
                                .matchedGeometryEffect(id: area.rawValue, in: animation)
                                .onTapGesture {
                                    if expandSearch {
                                        withAnimation(.spring()) {
                                            if let idx = selectedAreas.firstIndex(of: area) {
                                                selectedAreas.remove(at: idx)
                                            }
                                        }
                                    }
                                }
                        }
                    } else {
                        Text("Choose a category…")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 44)

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
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            if !expandSearch {
                withAnimation(.spring()) {
                    expandSearch = true
                }
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {
        Group {
            SearchBarView(
                expandSearch: .constant(true),
                selectedAreas: .constant([.groceryStores, .gasStations, .travel]),
                animation: animation
            )
            SearchBarView(
                expandSearch: .constant(true),
                selectedAreas: .constant([]),
                animation: animation,
            )
        }
    }
}
