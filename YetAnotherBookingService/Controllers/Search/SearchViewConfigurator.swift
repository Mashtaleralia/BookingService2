//
//  SearchViewControllerConfigurator.swift
//  YetAnotherBookingService
//
//  Created by Admin on 06.06.2024.
//

import Foundation

protocol SearchViewConfiguratorProtocol: AnyObject {
    func configure(vc: SearchViewController, view: TicketSearchView)
}

class SearchViewConfigurator: SearchViewConfiguratorProtocol {
    
    func configure(vc: SearchViewController, view: TicketSearchView) {
        let ticketSearchPresenter = TicketSearchViewPresenter()
        view.presenter = ticketSearchPresenter
        vc.delegate = view
        let presenter = SearchViewControllerPresenter()
        vc.presenter = presenter
        
    }
    
    
}
