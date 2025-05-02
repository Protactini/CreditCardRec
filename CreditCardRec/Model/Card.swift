//
//  UserData.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/30/25.
//


import SwiftUI

// MARK: – PAYMENT METHOD

enum PaymentMethod: String, CaseIterable, Identifiable {
    case visa
    case masterCard
    case discover

    var id: String { rawValue }
}

// MARK: – BANK CARDS MODEL

struct Card: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var paymentMethod: PaymentMethod
    var cashBack: [CashBack]?

    // Computed property: picks the right image based on paymentMethod
    var cardImage: String {
        switch paymentMethod {
        case .visa:
            let images = ["card1", "card2", "card3"]
            let index = Card.visaCounter % images.count
            Card.visaCounter += 1
            return images[0]
        case .masterCard:
            return "card4"
        case .discover:
            return "discover"
        }
    }

    // Hashable conformance (only by name)
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.name == rhs.name
    }

    // Static counter used to cycle through visa images
    private static var visaCounter = 0
}

// MARK: – CARD SAMPLE DATA

let cards: [Card] = [
    Card(name: "Chase Freedom Unlimited",
         paymentMethod: .visa,
         cashBack: chaseFreedomUnlimitedRates),

    Card(name: "Citi Double Cash",
         paymentMethod: .visa,
         cashBack: citiDoubleCashRates),

    Card(name: "Bank of America Customized Cash Rewards",
         paymentMethod: .masterCard,
         cashBack: boaCustomizedCashRates),

    Card(name: "Capital One Venture Rewards",
         paymentMethod: .visa,
         cashBack: capitalOneVentureRates),

    Card(name: "Apple Card",
         paymentMethod: .discover,
         cashBack: appleCardRates),

    Card(name: "Discover it Cash Back",
         paymentMethod: .discover,
         cashBack: discoverItRates),

    Card(name: "Amex Blue Cash Preferred",
         paymentMethod: .masterCard,
         cashBack: amexBlueCashRates),

    Card(name: "Wells Fargo Active Cash",
         paymentMethod: .masterCard,
         cashBack: wellsFargoActiveCashRates)
]
