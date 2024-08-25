//
//  TicketSearchPresenter.swift
//  YetAnotherBookingService
//
//  Created by Admin on 29.05.2024.
//

import Foundation

public protocol SearchViewProtocol: AnyObject {
    func setPlaceholderText()
}

class MainViewControllerPresenter {
    
    let router: MainViewRouter
    
    //weak var delegate: SearchViewProtocol?
    
    private var offers: [Offer] = [] {
        didSet {
            
        }
    }
    
    public var numberOfOffers: Int {
        return offers.count
    }
    
    public init(router: MainViewRouter) {
        self.router = router
    }
    
//    public func setUpCitiesText() -> (String, String)? {
//        guard let from = UserDefaults.standard.value(forKey: "1") as? String, let to = UserDefaults.standard.value(forKey: "2") as? String else {
//            return nil
//        }
//        return (from, to)
//    }
    
    private func getOffers() {
        APICaller.shared.getOffers { [weak self] result in
            switch result {
            case .success(let result):
                self?.offers = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func viewDidLoad() {
        getOffers()
       
    }
    
    public func jumpToSearch() {
        router.present()
    }
    
    public func configure(cell: MusicalCollectionViewCell, at index: Int) {
        cell.display(city: offers[index].town)
        cell.display(title: offers[index].title)
        cell.display(price: offers[index].price.value)
        //cell.display(price: 500)
        cell.display(imageid: offers[index].id.description)
    }
    
//    public func setPlaceholder() {
//        delegate?.setPlaceholderText()
//    }
//    
//    public func writeCityToCache(city: String, key: Int) {
//        UserDefaults.standard.set(city, forKey: key.description)
//       
//    }
    
}


