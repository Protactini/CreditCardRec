//
//  CardRebateRowView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 5/2/25.
//

import SwiftUI

struct CardRebateRowView: View {
    let card: Card
    let selectedAreas: [CashBackArea]
    var rootAnimation: Namespace.ID

    var body: some View {
        HStack {
            // Left: Card image
            Image(card.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 40)
                .padding(.leading)

            Spacer()

            // Right: Label showing single-area or average
            let label: String = {
                // Single selected area
                if selectedAreas.count == 1,
                   let area = selectedAreas.first,
                   let pct = card.cashBack?.first(where: { $0.area == area })?.percentage {
                    return "\(area.rawValue): \(String(format: "%.1f%%", pct))"
                }
                // Average over selected or all areas
                let areasToUse = selectedAreas.isEmpty ? CashBackArea.allCases : selectedAreas
                let total = areasToUse
                    .compactMap { area in
                        card.cashBack?.first(where: { $0.area == area })?.percentage
                    }
                    .reduce(0, +)
                let avg = total / Double(areasToUse.count)
                return String(format: "Average: %.1f%%", avg)
            }()

            Text(label)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
                .padding(.trailing)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
        .matchedGeometryEffect(id: card.id, in: rootAnimation)
    }
}

struct CardRebateRowView_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
        CardRebateRowView(
            card: cards.first!,
            selectedAreas: [],
            rootAnimation: ns
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
