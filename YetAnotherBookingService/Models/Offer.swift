//
//  Offer.swift
//  YetAnotherBookingService
//
//  Created by Admin on 02.06.2024.
//

import Foundation

struct Offers: Codable {
    var offers: [Offer]
}

struct Offer: Codable {
    let id: Int
    let title: String
    let town: String
    let price: Price
    struct Price: Codable {
        let value: Int
    }
}
