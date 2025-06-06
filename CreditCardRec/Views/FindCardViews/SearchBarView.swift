//
//  SearchBarView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/28/25.
//

import SwiftUI

struct SearchBarView: View {
    // User Data
    @EnvironmentObject var userData: UserData
    
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
                                .disabled(!expandSearch)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        if let idx = selectedAreas.firstIndex(of: area) {
                                            selectedAreas.remove(at: idx)
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
            .frame(height: expandSearch ? 44 : 35)


            if expandSearch {
                Button("OK") {
                    // Sort cards by total cash-back % across all selected areas (highest first)
                    userData.userCards.sort { lhs, rhs in
                        let lhsScore = selectedAreas.reduce(0) { sum, area in
                            sum + (lhs.cashBack?.first { $0.area == area }?.percentage ?? 0)
                        }
                        let rhsScore = selectedAreas.reduce(0) { sum, area in
                            sum + (rhs.cashBack?.first { $0.area == area }?.percentage ?? 0)
                        }
                        return lhsScore > rhsScore
                    }
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
        .contentShape(Rectangle())
        .disabled(!expandSearch)
        .simultaneousGesture(
          TapGesture().onEnded {
            if !expandSearch {
              withAnimation(.spring()) {
                expandSearch = true
              }
            }
          }
        )
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
            .environmentObject(UserData())
            SearchBarView(
                expandSearch: .constant(false),
                selectedAreas: .constant([]),
                animation: animation,
            )
            .environmentObject(UserData())
        }
    }
}
