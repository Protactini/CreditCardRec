//
//  Expense.swift
//  WalletUI
//
//  Created by Shameem Reza on 13/3/22.
//

import SwiftUI

// MARK: - EXPENSE MODEL

struct CashBack: Identifiable {
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}


// MARK: EXPENSE DATA

var cashBacks: [CashBack] = [

    CashBack(amountSpent: "$130", product: "Dribbble", productIcon: "icon1", spendType: "Membership"),
    CashBack(amountSpent: "$111", product: "Disney", productIcon: "icon2", spendType: "Streaming"),
    CashBack(amountSpent: "$130", product: "Ayana Mart", productIcon: "icon3", spendType: "Groceries"),
    CashBack(amountSpent: "&230", product: "Huawei", productIcon: "icon4", spendType: "Gadets"),
    CashBack(amountSpent: "$110", product: "House Remt", productIcon: "icon5", spendType: "Family"),
    CashBack(amountSpent: "$12", product: "Amazon Prime", productIcon: "icon6", spendType: "Movies"),
    CashBack(amountSpent: "$9", product: "Netflix", productIcon: "icon7", spendType: "Movies"),
    CashBack(amountSpent: "$90", product: "HP Development", productIcon: "icon8", spendType: "Computer"),
    CashBack(amountSpent: "$5", product: "Duolingo", productIcon: "icon9", spendType: "Membership"),
    CashBack(amountSpent: "$69", product: "Figma", productIcon: "icon10", spendType: "Membership"),
    CashBack(amountSpent: "$80", product: "Airbnb", productIcon: "icon11", spendType: "Tourism"),
    CashBack(amountSpent: "$10", product: "Soudagor", productIcon: "icon12", spendType: "Foods"),
    CashBack(amountSpent: "$330", product: "Apple", productIcon: "icon13", spendType: "Computer"),
    CashBack(amountSpent: "$21", product: "Facebook", productIcon: "icon14", spendType: "Advertising"),
]
