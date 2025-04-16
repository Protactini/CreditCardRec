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



// ----- Will put everything in the data abse in the future --------------------
// ----- Need to be able to auto updated ---------------------------------------

// MARK: - CARD SAMPLE DATA


let cards: [Card] = [
    Card(name: "Chase Freedom Unlimited",                 cardImage: "card1", cashBack: chaseFreedomUnlimitedRates),
    Card(name: "Citi Double Cash",                        cardImage: "card2", cashBack: citiDoubleCashRates),
    Card(name: "Bank of America Customized Cash Rewards", cardImage: "card3", cashBack: boaCustomizedCashRates),
    Card(name: "Capital One Venture Rewards",             cardImage: "card4", cashBack: capitalOneVentureRates),
    Card(name: "Apple Card",                              cardImage: "card1", cashBack: appleCardRates),
    Card(name: "Discover it Cash Back",                   cardImage: "card2", cashBack: discoverItRates),
    Card(name: "Amex Blue Cash Preferred",                cardImage: "card3", cashBack: amexBlueCashRates),
    Card(name: "Wells Fargo Active Cash",                 cardImage: "card4", cashBack: wellsFargoActiveCashRates)
]

var userCards: [Card] = []
