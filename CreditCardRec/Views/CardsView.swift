//
//  CardsView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct CardsView: View {
    // MARK: - CARD ANIAMTION PROPERTIES
    @State var expandCards: Bool = false
    
    // MARK: TRANSACTION LIST PROPERTIES
    @State var currentCard: Card?
    @State var showDetailCashBack: Bool = false
    @Namespace var animation
    var showCards = userCards
    
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack {
                    // Mark: Header
                    Text("Cards")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .offset(y: 5)
                    
                    Divider().padding().offset(y: 5)
                    
                    // MARK: - CARD LIST
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
        //                    // For open the details
        //                    .onTapGesture {
        //                        withAnimation(.easeInOut(duration: 0.35)) {
        //                            currentCard = card
        //                            showDetailCashBack = true
        //                        }
        //                    }
                        }
                    }
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(expandCards ? 0 : 0.01))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    expandCards = !expandCards
                                }
                            }
                    }
                    .padding(.top, expandCards ? 30 : 0)
                }
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 0 : 30)
        }
    }
    
    // MARK: CARD VIEW
    @ViewBuilder
    func CardView(card: Card)->some View {
        GeometryReader {proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            let offset = CGFloat(getIndex(Card: card) * (expandCards ? 10 : 70))
            
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
            .offset(y: expandCards ? offset: -rect.minY + offset)
        }
        .frame(height: 200)
        .padding(.horizontal)
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
        CardsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
