//
//  DatePickerView.swift
//  YetAnotherBookingService
//
//  Created by Admin on 10.06.2024.
//

import UIKit

class DatePickerView: UIView {

    var changeClosure: ((Date) -> ())?
    var dismissClosure: (() -> ())?
    
    let dPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.isUserInteractionEnabled = true
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        
        let pickerHolderView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 8
            return view
        }()
        
        [blurredEffectView, pickerHolderView, dPicker].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(blurredEffectView)
        pickerHolderView.addSubview(dPicker)
        addSubview(pickerHolderView)
        
        NSLayoutConstraint.activate([
            
            blurredEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurredEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            pickerHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            pickerHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            //pickerHolderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pickerHolderView.topAnchor.constraint(equalTo: topAnchor, constant: 120),

            dPicker.topAnchor.constraint(equalTo: pickerHolderView.topAnchor, constant: 20.0),
            dPicker.leadingAnchor.constraint(equalTo: pickerHolderView.leadingAnchor, constant: 20.0),
            dPicker.trailingAnchor.constraint(equalTo: pickerHolderView.trailingAnchor, constant: -20.0),
            dPicker.bottomAnchor.constraint(equalTo: pickerHolderView.bottomAnchor, constant: -20.0),
        ])
        
        if #available(iOS 14.0, *) {
            dPicker.preferredDatePickerStyle = .inline
        } else {
            // use default
        }
        
        dPicker.addTarget(self, action: #selector(didChangeDate(_:)), for: .valueChanged)
        
        let t = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        blurredEffectView.addGestureRecognizer(t)
        
    }
    
    @objc func didChangeDate(_ sender: UIDatePicker) {
        changeClosure?(sender.date)
    }
    
    @objc func tapHandler(_ g: UITapGestureRecognizer) {
        dismissClosure?()
    }

}
