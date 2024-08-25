//
//  MainViewRouter.swift
//  YetAnotherBookingService
//
//  Created by Admin on 04.06.2024.
//

import Foundation

protocol MainViewRouterProtocol: AnyObject {
    
}

class MainViewRouter: MainViewRouterProtocol {
    fileprivate weak var mainViewController: MainViewController?
    
    init(vc: MainViewController) {
        self.mainViewController = vc
    }
    
    public func present() {
        let searchVC = SearchViewController()
        mainViewController?.present(searchVC, animated: true, completion: nil)
    }
    
}
