//
//  Post.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 5/6/25.
//


// Post.swift
import Foundation

struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
}
