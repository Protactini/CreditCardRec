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
    
    // MARK: - CARD ANIAMTION PROPERTIES
    @State var expandCards: Bool = false
    
    // MARK: TRANSACTION LIST PROPERTIES
    @State var currentCard: Card?
    @State var showDetailCashBack: Bool = false
    @Namespace var animation
    var showCards = cards
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Mark: Header
                Text("Cards")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .overlay(alignment: .trailing) {
                    // MARK: CLOSE BUTTON
                    // Conditional button: plus when expandCards is false, cross when true.
                    Button {
                        if expandCards {
                            // Toggle expandCards state on tap.
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
                        // Rotate 45° when expandCards is true.
                        .rotationEffect(.degrees(expandCards ? 45 : 0))
                    }
                    .offset(x: -25)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
                // Outlines the outer frame
                .debugBorder(DebugConfig.color(at: 1))
                
                // MARK: - CARD LIST
                    
                ScrollView() {
                    VStack(spacing: 0) {
                        ForEach(showCards) {card in
                            Group {
                                if currentCard?.id == card.id && showDetailCashBack {
                                    CardView(card: card)
                                        .opacity(0)
                                } else {
                                    CardView(card: card)
                                        .matchedGeometryEffect(id: card.id, in: animation)
                                }
                            }
                        }
                    }
                    .overlay {
                        Rectangle()
                        .fill(.black.opacity(0.01))
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                                expandCards = !expandCards
                            }
                        }
                    }
                    .padding(.top, expandCards ? 30 : 0)
                    // MARK: set the bottom line of the scroll view
                    .padding(.bottom, -7 * 100 + 50) // need to change with the size ofshowCards
                    .offset(y: 50)
                }
                .scrollDisabled(false)
            }
        }
        .coordinateSpace(name: "SCROLL")
        .offset(y: expandCards ? 0 : 30)
    }
    
    // MARK: CARD VIEW
    @ViewBuilder
    func CardView(card: Card)->some View {
        GeometryReader {proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            
            // Offset parameters for card view
//            let offset = CGFloat(getIndex(Card: card) * (expandCards ? 10 : 70))
            let cardOffSet = -CGFloat(getIndex(Card: card) * 100)
            let offTop: CGFloat = 150
            let stickyOffset =  rect.minY + cardOffSet < offTop ? -rect.minY  + offTop: cardOffSet
            
            ZStack(alignment: .bottomLeading) {
                
                // MARKK - CARD BACKGROUND
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // MARK: - CARD DETAILS
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name)
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.bottom, 10)
                .foregroundColor(.white)
            }
            .offset(y: stickyOffset)
            // Center the ZStack horizontally within the available space.
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            // Outlines the outer frame
            .debugBorder(DebugConfig.color(at: 1))
            
        }
        .frame(height: 200)
        .padding(.horizontal)
        // Outlines the outer frame
        .debugBorder(DebugConfig.color(at: 2))
    }
    
    // MARK: - GET CARD INDEX NUMBER
    func getIndex(Card: Card)-> Int {
        return showCards.firstIndex { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
}


struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview purposes, we inject a preview Core Data context.
        CardsView(showOverlay: { }).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
