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

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: Search Bar
                SearchBarView(expandSearch: $expandSearch, selectedAreas: $selectedAreas, animation: animation)
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
                        FindCardSearchOverlayView(selectedAreas: $selectedAreas, animation: animation)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
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
