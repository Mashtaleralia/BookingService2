//
//  TicketSearchView.swift
//  YetAnotherBookingService
//
//  Created by Admin on 29.05.2024.
//

import UIKit

protocol TicketSearchViewTextFieldDelegate: AnyObject {
    func textFieldSetUp(vc: UITextFieldDelegate)
}

protocol TicketSearchViewNavigationDelegate: AnyObject {
    func jumpTo()
}

protocol TicketSearchOptionsDelegate: AnyObject {
    func switchCitiesText()
    func eraseBottomCityText()
}

class TicketSearchView: UIView, TicketSearchViewTextFieldDelegate {

    
    var presenter: TicketSearchViewPresenter!
    
    weak var delegate: TicketSearchViewNavigationDelegate?
//
//    private let searchPaddingView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
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
        topTextField.addTarget(self, action: #selector(didEditTopField(_:)), for: .editingDidEnd)
        bottomTextField.addTarget(self, action: #selector(didEditBottomField(_:)), for: .editingDidEnd)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didEditTopField(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        presenter.writeCityToCache(city: text, key: textField.tag)
    }
    
    @objc private func didEditBottomField(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        presenter.writeCityToCache(city: text, key: textField.tag)
        //presenter.jumpToSearch()
        if let parentVC = getParentViewController() as? MainViewController {
            delegate?.jumpTo()
        }
    
    }
    
    private func setUp() {
        backgroundColor = Style().backgroundColor
        layer.cornerRadius = 16
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        topTextField.tag = 1
        bottomTextField.tag = 2
        addSubview(topTextField)
        addSubview(bottomTextField)
        addSubview(glassIcon)
        addConstraints()
    }
    
    func textFieldSetUp(vc: UITextFieldDelegate) {
        topTextField.delegate = vc
        bottomTextField.delegate = vc
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

extension TicketSearchView: SearchViewProtocol {
    
    func setPlaceholderText() {
//        guard let presenter = presenter else {
//            print("presenter nil")
//            return
//        }
        guard let top = presenter.setUpCitiesText()?.0, let bottom = presenter.setUpCitiesText()?.1 else {
            return
        }
        if let parentVC = getParentViewController() as? SearchViewController {
            topTextField.text = top
            bottomTextField.text = bottom
        }
        topTextField.placeholder = "Куда - " + top
        bottomTextField.placeholder = "Откуда - " + bottom
    }
    
}

extension TicketSearchView: TicketSearchOptionsDelegate {
    
    func switchCitiesText() {
        guard let topText = topTextField.text, !topText.isEmpty, let bottomText = bottomTextField.text, !bottomText.isEmpty else {
            return
        }
        
        topTextField.text = bottomText
        bottomTextField.text = topText
        
    }
    
    func eraseBottomCityText() {
        guard let bottomText = bottomTextField.text, !bottomText.isEmpty else {
            return
        }
        
        bottomTextField.text = ""
        
    }
    
    
}
