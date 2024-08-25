//
//  APICaller.swift
//  YetAnotherBookingService
//
//  Created by Admin on 02.06.2024.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case dataError
}

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getOffers(completion: @escaping (Result<[Offer], APIError>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.dataError))
                return
            }
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(json)
                let offers = try JSONDecoder().decode(Offers.self, from: data)
                completion(.success(offers.offers))
            } catch {
                print("cannot decode")
            }
        }
        
        task.resume()
    }
    
    public func getTicketOffers(completion: @escaping (Result<[TicketOffer], APIError>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.dataError))
                return
            }
            
            do {
                let offers = try JSONDecoder().decode(TicketOffers.self, from: data)
                completion(.success(offers.tickets_offers))
            } catch {
                print("cannot decode")
            }
        }
        
        task.resume()
    }
}
