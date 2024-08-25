//
//  SearchViewPresenter.swift
//  YetAnotherBookingService
//
//  Created by Admin on 06.06.2024.
//

import Foundation
import UIKit

protocol SearchViewPresenterProtocol {
    func viewDidLoad()
    func configure(cell: TicketViewCell, for indexPath: Int)
    var numberOfTicketOffers: Int {get}
}

class SearchViewControllerPresenter: SearchViewPresenterProtocol {
    
    private var ticketOffers: [TicketOffer] = []
    var numberOfTicketOffers: Int {
        return ticketOffers.count
    }
    
    func viewDidLoad() {
        getTicketOffers()
    }
    
    func configure(cell: TicketViewCell, for indexPath: Int) {
        cell.display(airline: ticketOffers[indexPath].title)
        cell.display(price: ticketOffers[indexPath].price.value.description)
        cell.display(times: ticketOffers[indexPath].time_range.reduce("", {$0 + " " + $1}))
    }
    
    private func getTicketOffers() {
        APICaller.shared.getTicketOffers { [weak self] result in
            switch result {
            case .success(let offers):
                self?.ticketOffers = offers
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
