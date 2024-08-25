//
//  TicketSearchViewConfigurator.swift
//  YetAnotherBookingService
//
//  Created by Admin on 30.05.2024.
//

import UIKit

protocol MainViewConfiguratorProtocol {
    func configure(vc: MainViewController, view: TicketSearchView)
}

class MainViewConfigurator: MainViewConfiguratorProtocol {
    
    func configure(vc: MainViewController, view: TicketSearchView) {
        vc.delegate = view
        view.delegate = vc
        let router = MainViewRouter(vc: vc)
        let presenter = MainViewControllerPresenter(router: router)
        let searchPresenter = TicketSearchViewPresenter()
        searchPresenter.delegate = view
        view.presenter = searchPresenter
        searchPresenter.setPlaceholder()
        vc.presenter = presenter
    }
    
}
