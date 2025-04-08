//
//  Card.swift
//  WalletUI
//
//  Created by Shameem Reza on 13/3/22.
//

import SwiftUI

// MARK: BANK CARDS MODEL

struct Card: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var cardImage: String
    var cashBack: [CashBack]?
    
    // Conformance to Hashable: only the name is used for hashing.
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    // Equality is determined solely by the name.
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.name == rhs.name
    }
}


// MARK: - CARD SAMPLE DATA

var cards: [Card] = [
    Card(name: "Chase Freedom Unlimited", cardImage: "card1", cashBack: cashBacks),
    Card(name: "Citi Double Cash", cardImage: "card2", cashBack: cashBacks),
    Card(name: "Bank of America Customized Cash Rewards", cardImage: "card3", cashBack: cashBacks),
    Card(name: "Capital One Venture Rewards", cardImage: "card4", cashBack: cashBacks),
//    Card(name: "Apple Card", cardImage: "card4", cashBack: cashBacks),
//    Card(name: "Discover it", cardImage: "card4", cashBack: cashBacks),
//    Card(name: "Amex Blue Cash", cardImage: "card4", cashBack: cashBacks),
//    Card(name: "Wells Fargo Cash Back", cardImage: "card4", cashBack: cashBacks),
]

var userCards: [Card] = []
