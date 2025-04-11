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
    @State private var currentCard: Card? = nil           // CHANGED: private
    @State private var showDetailCashBack = false         // CHANGED: private
    @Namespace private var animation                      // CHANGED: private

    var showCards = cards

    // Compute bottom padding once
    private var bottomPadding: CGFloat {
        let count = CGFloat(showCards.count)
        return -((count - 1) * 100) + 30
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: Header
                Text("Cards")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .overlay(alignment: .trailing) {
                        Button {
                            if expandCards {
                                withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    expandCards.toggle()
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
                ScrollViewReader { reader in                                 // NEW
                    ZStack {
                        ScrollView {                                      // CHANGED: moved ScrollView here
                            VStack(spacing: 0) {
                                ForEach(showCards) { card in
                                    // Use shared CardView and pass onTap action
                                    CardView(card: card) {               // CHANGED
                                        withAnimation(.spring()) {
                                            expandCards.toggle()
                                            showDetailCashBack.toggle()
                                            currentCard = card
                                        }
                                    }
                                    .matchedGeometryEffect(id: card.id, in: animation)
                                    .id(card.id)                        // NEW: identify for scrolling
                                }
                            }
//                            .padding(.top, expandCards ? 0 : -30)
                            .padding(.bottom, bottomPadding)         // CHANGED
                        }
                        .scrollDisabled(expandCards)                  // NEW: disable scroll when folded
                        .coordinateSpace(name: "SCROLL")               // NEW: coordinate space for GeometryReader
                    }
                }

            }
            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if let card = currentCard, showDetailCashBack {
                    TransactionView(
                        currentCard: card,
                        showDetailTransaction: $showDetailCashBack,
                        animation: animation
                    )
                }
            }
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
