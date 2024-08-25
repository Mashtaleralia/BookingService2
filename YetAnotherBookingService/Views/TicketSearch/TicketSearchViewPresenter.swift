//
//  TicketSearchViewPresenter.swift
//  YetAnotherBookingService
//
//  Created by Admin on 05.06.2024.
//

import Foundation

protocol TicketSearchPresenterProtocol: AnyObject {
    
}

class TicketSearchViewPresenter {
    
    weak var delegate: SearchViewProtocol?
    
    public func setUpCitiesText() -> (String, String)? {
        guard let from = UserDefaults.standard.value(forKey: "1") as? String, let to = UserDefaults.standard.value(forKey: "2") as? String else {
            return nil
        }
        return (from, to)
    }
    
    public func setPlaceholder() {
        delegate?.setPlaceholderText()
    }
    
    public func writeCityToCache(city: String, key: Int) {
        UserDefaults.standard.set(city, forKey: key.description)
       
    }
}
