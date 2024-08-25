//
//  TicketOfferTableViewCell.swift
//  YetAnotherBookingService
//
//  Created by Admin on 11.06.2024.
//

import UIKit

protocol TicketViewCell {
    func display(airline: String)
    func display(times: String)
    func display(price: String)
}

class TicketOfferTableViewCell: UITableViewCell, TicketViewCell {
    
    static let identifier = "TicketOfferTableViewCell"

    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let airlineNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Уральские авиалинии"
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timesLabel: UILabel = {
        let label = UILabel()
        label.text = "08:05  09:55   16:35  18:55"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .italicSystemFont(ofSize: 14)
        label.text = "2 390 ₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(circleView)
        addSubview(airlineNameLabel)
        addSubview(timesLabel)
        addSubview(priceLabel)
        addConstraints()
        backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 32/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            circleView.heightAnchor.constraint(equalToConstant: 24),
            circleView.widthAnchor.constraint(equalToConstant: 24),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            airlineNameLabel.topAnchor.constraint(equalTo: circleView.topAnchor),
            airlineNameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 5),
            timesLabel.leadingAnchor.constraint(equalTo: airlineNameLabel.leadingAnchor),
            timesLabel.topAnchor.constraint(equalTo: airlineNameLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: airlineNameLabel.topAnchor)
        ])
    }
    
    func display(airline: String) {
        airlineNameLabel.text = airline
    }
    
    func display(times: String) {
        timesLabel.text = times
    }
    
    func display(price: String) {
        priceLabel.text = price + " ₽"
    }
    

}
