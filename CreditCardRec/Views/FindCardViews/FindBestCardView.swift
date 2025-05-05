//
//  FindBestCardView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct FindBestCardView: View {
    // User Data
    @EnvironmentObject var userData: UserData
    
    // Controls whether the search overlay is showing
    @State private var expandSearch = false
    
    // The area selected in the search overlay
    @State private var selectedAreas: [CashBackArea] = []
    
    // Namespace for matched‐geometry effects between the bar and overlay
    @Namespace private var animation
    // CHANGED: private
    var rootAnimation: Namespace.ID                    

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: Search Bar
                SearchBarView(expandSearch: $expandSearch, selectedAreas: $selectedAreas, animation: animation)
                .debugBorder(DebugConfig.color(at: 2))
                

                ZStack{
                    // MARK: Card List
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(userData.userCards) { card in
                                    CardRebateRowView(card: card, selectedAreas: selectedAreas, rootAnimation: rootAnimation)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 0)
                            .animation(.spring().delay(0.1), value: userData.userCards)
                        }
                        .zIndex(0)
                    
                    
                    // MARK: Search Overlay
                    if expandSearch {
                        // Grid of all areas
                        FindCardSearchOverlayView(expandSearch: $expandSearch, selectedAreas: $selectedAreas, animation: rootAnimation)
                        
                        .background(Color(.systemBackground).ignoresSafeArea())
                        .transition(.opacity.animation(.spring()))
                        .padding(.horizontal)
                        .zIndex(1)
                        .debugBorder(DebugConfig.color(at: 1))
                        
                    }
                }
            }
        }
    }
}

struct FindBestCardView_Previews: PreviewProvider {
    // Create a namespace for the matchedGeometryEffect
    @Namespace static var rootAnimation
    
    static var previews: some View {
        FindBestCardView(rootAnimation: rootAnimation)
            .environmentObject(UserData())
    }
}
