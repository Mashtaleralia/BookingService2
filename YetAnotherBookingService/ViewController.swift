//
//  ViewController.swift
//  YetAnotherBookingService
//
//  Created by Admin on 28.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let style: StyleProvider = Style()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Поиск дешевых авиабилетов"
        label.textAlignment = .center
        label.font = Style().title1
        label.textColor = Style().textColor
        return label
    }()
    
    private var ticketSearchView = TicketSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(headerLabel)
        view.addSubview(ticketSearchView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 100),
            headerLabel.widthAnchor.constraint(equalToConstant: 172),
            ticketSearchView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 35),
            ticketSearchView.heightAnchor.constraint(equalToConstant: 90),
            ticketSearchView.widthAnchor.constraint(equalToConstant: 296),
            ticketSearchView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    
}

