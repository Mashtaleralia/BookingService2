//
//  ViewController.swift
//  YetAnotherBookingService
//
//  Created by Admin on 28.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Поиск дешевых авиабилетов"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(headerLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 100),
            headerLabel.widthAnchor.constraint(equalToConstant: 172)
        ])
    }
    
    
    
    
}

