//
//  CardView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/11/25.
//


import SwiftUI

struct CardView: View {
    let card: Card
    var onTap: (() -> Void)? = nil   // optional tap handler

    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("SCROLL"))
            let cardOffset = -CGFloat(getIndex(of: card) * 100)
            let offTop: CGFloat = 0
            let stickyOffset = rect.minY + cardOffset < offTop
                ? -rect.minY + offTop
                : cardOffset

            ZStack(alignment: .bottomLeading) {
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name)
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.bottom, 10)
                .foregroundColor(.white)
            }
            .offset(y: stickyOffset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 200)
        .padding(.horizontal)
        .onTapGesture {
            onTap?()
        }
    }

    // Helper to find the index in the global `cards` array
    private func getIndex(of card: Card) -> Int {
        cards.firstIndex { $0.id == card.id } ?? 0
    }
}
