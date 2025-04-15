//
//  Expense.swift
//  WalletUI
//
//  Created by Shameem Reza on 13/3/22.
//

import SwiftUI

// MARK: – CASH BACK AREAS

enum CashBackArea: String, CaseIterable, Identifiable {
    case groceryStores       = "Grocery Stores"
    case gasStations         = "Gas Stations"
    case evCharging          = "EV Charging"
    case diningRestaurants   = "Dining & Restaurants"
    case onlineShopping      = "Online Shopping"
    case travel              = "Travel"
    case streamingServices   = "Streaming Services"
    case drugstores          = "Drugstores"
    case homeImprovement     = "Home Improvement Stores"
    case transitCommuting    = "Transit & Commuting"
    case wholesaleClubs      = "Wholesale Clubs"
    
    var id: String { rawValue }
}

// MARK: – CASH BACK RATE MODEL

struct CashBack: Identifiable {
    var id = UUID().uuidString
    var area: CashBackArea
    var productIcon: String
    var percentage: Double   // e.g. 2.5 means 2.5%
}

// MARK: – SAMPLE RATES

let cashBacks: [CashBack] = [
    CashBack(area: .groceryStores,     productIcon: "icon1", percentage: 3.0),
    CashBack(area: .gasStations,       productIcon: "icon2", percentage: 2.0),
    CashBack(area: .evCharging,        productIcon: "icon3", percentage: 1.5),
    CashBack(area: .diningRestaurants, productIcon: "icon4", percentage: 4.0),
    CashBack(area: .onlineShopping,    productIcon: "icon5", percentage: 1.0),
    CashBack(area: .travel,            productIcon: "icon6", percentage: 2.5),
    CashBack(area: .streamingServices, productIcon: "icon7", percentage: 1.0),
    CashBack(area: .drugstores,        productIcon: "icon8", percentage: 1.5),
    CashBack(area: .homeImprovement,   productIcon: "icon9", percentage: 2.0),
    CashBack(area: .transitCommuting,  productIcon: "icon10", percentage: 3.0),
    CashBack(area: .wholesaleClubs,    productIcon: "icon11", percentage: 1.0)
]
