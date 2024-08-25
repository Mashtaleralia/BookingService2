//
//  TicketOffer.swift
//  YetAnotherBookingService
//
//  Created by Admin on 10.06.2024.
//

import Foundation

struct TicketOffers: Codable {
    var tickets_offers: [TicketOffer]
}

struct TicketOffer: Codable {
    var id: Int
    var title: String
    var time_range: [String]
    let price: Price
    struct Price: Codable {
        let value: Int
    }
}
