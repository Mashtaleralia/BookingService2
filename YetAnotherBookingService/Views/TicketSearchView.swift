//
//  TicketSearchView.swift
//  YetAnotherBookingService
//
//  Created by Admin on 29.05.2024.
//

import UIKit

class TicketSearchView: UIView {
    
    private let topTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .alphabet
        textField.textAlignment = .left
        textField.textColor = Style().textColor
        textField.attributedPlaceholder = NSAttributedString(
            string: "Откуда - Минск",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)])
        return textField
    }()
    
    private let bottomTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .alphabet
        textField.textAlignment = .left
        textField.textColor = Style().textColor
        textField.attributedPlaceholder = NSAttributedString(
            string: "Куда - Оттава",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)])
        return textField
    }()
    
    private let glassIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "glassIcon")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = Style().backgroundColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(topTextField)
        addSubview(bottomTextField)
        addSubview(glassIcon)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            glassIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            glassIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            glassIcon.widthAnchor.constraint(equalToConstant: 24),
            glassIcon.heightAnchor.constraint(equalToConstant: 24),
            topTextField.leadingAnchor.constraint(equalTo: glassIcon.trailingAnchor, constant: 10),
            topTextField.topAnchor.constraint(equalTo: topAnchor),
            topTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            topTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomTextField.leadingAnchor.constraint(equalTo: glassIcon.trailingAnchor, constant: 10),
            bottomTextField.topAnchor.constraint(equalTo: topTextField.bottomAnchor),
            bottomTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
           

        ])
    }
    
}
