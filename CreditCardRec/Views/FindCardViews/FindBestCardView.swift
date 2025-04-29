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
    @State private var selectedAreas: [CashBackArea] = []
    
    // Namespace for matched‐geometry effects between the bar and overlay
    @Namespace private var animation

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: Search Bar
                SearchBarView(cardsList: $cardsList, expandSearch: $expandSearch,
                              selectedAreas: $selectedAreas, animation: animation)
                .debugBorder(DebugConfig.color(at: 2))
                

                ZStack{
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
                            .animation(.spring().delay(0.1), value: cardsList)
                        }
                        .zIndex(0)
                    
                    
                    // MARK: Search Overlay
                    if expandSearch {
                        // Grid of all areas
                        FindCardSearchOverlayView(expandSearch: $expandSearch, selectedAreas: $selectedAreas, animation: animation)
                        
                        .background(Color(.systemBackground).ignoresSafeArea())
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
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
    static var previews: some View {
        FindBestCardView()
    }
}
