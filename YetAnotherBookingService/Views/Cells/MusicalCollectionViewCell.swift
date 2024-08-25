//
//  MusicalCollectionViewCell.swift
//  YetAnotherBookingService
//
//  Created by Admin on 31.05.2024.
//

import UIKit

protocol MusicalCellView {
    func display(imageid: String)
    func display(title: String)
    func display(city: String)
    func display(price: Int)
}

class MusicalCollectionViewCell: UICollectionViewCell, MusicalCellView {
    
    static let identifier = "MusicalCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Style().title1
        label.textAlignment = .left
        label.textColor = Style().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Style().title2
        label.textAlignment = .left
        label.textColor = Style().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Style().title2
        label.textAlignment = .left
        label.textColor = Style().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let airplaneIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "plane"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(cityLabel)
        addSubview(priceLabel)
        addSubview(airplaneIcon)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 132),
            imageView.widthAnchor.constraint(equalToConstant: 132),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            airplaneIcon.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            airplaneIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
            airplaneIcon.heightAnchor.constraint(equalToConstant: 24),
            airplaneIcon.widthAnchor.constraint(equalToConstant: 24),
            priceLabel.leadingAnchor.constraint(equalTo: airplaneIcon.trailingAnchor, constant: -5),
            priceLabel.centerYAnchor.constraint(equalTo: airplaneIcon.centerYAnchor)
        ])
    }
    
    func display(imageid: String) {
        imageView.image = UIImage(named: "id" + imageid)
    }
    
    func display(title: String) {
        titleLabel.text = title
    }
    
    func display(city: String) {
        cityLabel.text = city
    }
    
    func display(price: Int) {
        priceLabel.text = "от " + price.description + "₽"
    }
}
