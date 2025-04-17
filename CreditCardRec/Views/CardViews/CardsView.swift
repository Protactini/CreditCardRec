//
//  CardsView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct CardsView: View {
    // MARK: For overlay content
    let showOverlay: () -> Void
    
    // MARK: - CARD ANIMATION PROPERTIES
    @State private var expandCards = false                // CHANGED: private
    @State private var currentCard: Card? = nil             // CHANGED: private
    @Namespace private var animation                      // CHANGED: private

    var showCards = cards
    private var pageName: String {
        if expandCards, let card = currentCard {
            // Split on spaces, take first component, or default to full name
            let firstWord = card.name.components(separatedBy: " ").first ?? card.name
            return firstWord
        } else {
            return "Cards"
        }
    }

    // Compute bottom padding once
    private var bottomPadding: CGFloat {
        let count = CGFloat(showCards.count)
        return -((count - 1) * 100) + 30
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: Header
                Text(pageName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .overlay(alignment: .trailing) {
                        Button {
                            if expandCards {
                                withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    expandCards = false
                                }
                            } else {
                                showOverlay()
                            }
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(expandCards ? Color.pink : Color.black, in: Circle())
                                .rotationEffect(.degrees(expandCards ? 45 : 0))
                        }
                        .offset(x: -25)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                    .debugBorder(DebugConfig.color(at: 1))
                
                
                Rectangle()
                    .opacity(0)
                    .frame(height: 40)

                // MARK: - CARD LIST
                ZStack {
                    if !expandCards {
                        ScrollViewReader { reader in                                 // NEW
                            ZStack {
                                ScrollView {                                      // CHANGED: moved ScrollView here
                                    VStack(spacing: 0) {
                                        ForEach(showCards) { card in
                                            // Use shared CardView and pass onTap action
                                            CardView(
                                                expandCards: $expandCards,
                                                card: card
                                            ) {               // CHANGED
                                                withAnimation(.spring()) {
                                                    expandCards = true
                                                    currentCard = card
                                                }
                                            }
                                            .matchedGeometryEffect(id: card.id, in: animation)
                                            .id(card.id)                        // NEW: identify for scrolling
                                        }
                                    }
                                    .padding(.bottom, bottomPadding)
                                }
                                .scrollDisabled(expandCards)                  // NEW: disable scroll when folded
                                .coordinateSpace(name: "SCROLL")               // NEW: coordinate space for GeometryReader
                            }
                        }
                    }
                    if let card = currentCard, expandCards {
                        CashBackView(
                            currentCard: card,
                            expandCards: $expandCards,
                            animation: animation
                        )
                    }
                }
            }
            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Preview

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView(showOverlay: { })
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
