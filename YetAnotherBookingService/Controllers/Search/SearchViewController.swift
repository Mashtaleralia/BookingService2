//
//  SearchViewController.swift
//  YetAnotherBookingService
//
//  Created by Admin on 04.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let configurator = SearchViewConfigurator()
    
    weak var delegate: TicketSearchOptionsDelegate?
    
    public var presenter: SearchViewPresenterProtocol!
    
    private var searchView = TicketSearchView()
    
    private let datePicker = DatePickerView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TicketOfferTableViewCell.self, forCellReuseIdentifier: TicketOfferTableViewCell.identifier)
        table.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 32/255, alpha: 1)
        table.layer.cornerRadius = 16
        return table
    }()
    
    private let viceVersaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .red
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrow.right.arrow.left.square"), for: .normal)
        return button
    }()
    
    private let eraseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        //button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .red
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        return button
    }()
   
    private let pickDepartureDateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Style().backgroundColor
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let pickArrivalDateButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.titleLabel?.font = .italicSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("24 феб, сб", for: .normal)
        button.backgroundColor = Style().backgroundColor
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let additionalFeaturesButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Style().backgroundColor
        button.layer.cornerRadius = 18
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(vc: self, view: searchView)
        presenter.viewDidLoad()
        
        view.backgroundColor = .black
        setUpTableView()
        configureButtons()
        configureSearchView()
        addConstraints()
        viceVersaButton.addTarget(self, action: #selector(didTapViceVersa), for: .touchUpInside)
        eraseButton.addTarget(self, action: #selector(didTapErase), for: .touchUpInside)
        pickArrivalDateButton.addTarget(self, action: #selector(didTapPickDate), for: .touchUpInside)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    @objc private func didTapViceVersa() {
        delegate?.switchCitiesText()
    }
    
    @objc private func didTapErase() {
        delegate?.eraseBottomCityText()
    }
    
    @objc private func didTapPickDate() {
        datePicker.isHidden = false
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureButtons() {
        view.addSubview(pickDepartureDateButton)
        view.addSubview(pickArrivalDateButton)
        view.addSubview(additionalFeaturesButton)
        view.addSubview(datePicker)
        
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        pickDepartureDateButton.addSubview(imageView)
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Обратно"
        label.textColor = .white
        pickDepartureDateButton.addSubview(label)
        
        let personIcon = UIImageView(image: UIImage(systemName: "person.fill"))
        personIcon.translatesAutoresizingMaskIntoConstraints = false
        let addLabel = UILabel()
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        addLabel.font = .italicSystemFont(ofSize: 14)
        addLabel.textColor = .white
        addLabel.text = "1, эконом"
        additionalFeaturesButton.addSubview(personIcon)
        additionalFeaturesButton.addSubview(addLabel)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: pickDepartureDateButton.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: pickDepartureDateButton.leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            label.centerYAnchor.constraint(equalTo: pickDepartureDateButton.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: pickDepartureDateButton.trailingAnchor, constant: -8),
            personIcon.centerYAnchor.constraint(equalTo: additionalFeaturesButton.centerYAnchor),
            personIcon.leadingAnchor.constraint(equalTo: additionalFeaturesButton.leadingAnchor, constant: 8),
            personIcon.heightAnchor.constraint(equalToConstant: 16),
            personIcon.widthAnchor.constraint(equalToConstant: 16),
            addLabel.leadingAnchor.constraint(equalTo: personIcon.trailingAnchor, constant: 6),
            addLabel.centerYAnchor.constraint(equalTo: additionalFeaturesButton.centerYAnchor),
            addLabel.trailingAnchor.constraint(equalTo: additionalFeaturesButton.trailingAnchor, constant: -8),
            
            datePicker.topAnchor.constraint(equalTo: view.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        datePicker.isHidden = true
        
        datePicker.dismissClosure = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.datePicker.isHidden = true
        }
        
        datePicker.changeClosure = { [weak self] date in
            guard let self = self else {
                return
            }
            print(date)
        }
        
    }
//
//    private func configureDeparturePickButton() {
//        let date: Date = .now
//
//        let components = Calendar.current.dateComponents([.day, .month, .weekdayOrdinal], from: date)
//        print(Calendar.current.date(from: components))
//        print(date)
//        //pickDepartureDateButton.setTitle(, for: .normal)
//    }
    
    private func configureSearchView() {
        view.addSubview(searchView)
        searchView.addSubview(viceVersaButton)
        searchView.addSubview(eraseButton)
        searchView.setPlaceholderText()
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchView.heightAnchor.constraint(equalToConstant: 90),
            viceVersaButton.heightAnchor.constraint(equalToConstant: 24),
            viceVersaButton.widthAnchor.constraint(equalToConstant: 24),
            viceVersaButton.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 12),
            viceVersaButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -12),
            eraseButton.heightAnchor.constraint(equalToConstant: 24),
            eraseButton.widthAnchor.constraint(equalToConstant: 24),
            eraseButton.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -12),
            eraseButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -12),
            //additionalFeaturesButton.heightAnchor.constraint(equalToConstant: 33),
            
            pickDepartureDateButton.heightAnchor.constraint(equalToConstant: 33),
            pickDepartureDateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pickDepartureDateButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            pickDepartureDateButton.widthAnchor.constraint(equalToConstant: 105),
            
            
            pickArrivalDateButton.heightAnchor.constraint(equalToConstant: 33),
            pickArrivalDateButton.leadingAnchor.constraint(equalTo: pickDepartureDateButton.trailingAnchor, constant: 10),
            pickArrivalDateButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            pickArrivalDateButton.widthAnchor.constraint(equalToConstant: 105),
            
            additionalFeaturesButton.heightAnchor.constraint(equalToConstant: 33),
            additionalFeaturesButton.leadingAnchor.constraint(equalTo: pickArrivalDateButton.trailingAnchor, constant: 10),
            additionalFeaturesButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            additionalFeaturesButton.widthAnchor.constraint(equalToConstant: 105),
            
            //pickArrivalDateButton.heightAnchor.constraint(equalToConstant: 33),
           
            
            tableView.topAnchor.constraint(equalTo: additionalFeaturesButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 238)
        ])
    }
   

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTicketOffers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketOfferTableViewCell.identifier, for: indexPath) as?  TicketOfferTableViewCell else {
            fatalError()
        }
        presenter.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.textColor = .white
        label.text = "Прямые рейсы"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: headerView.topAnchor)
            
        ])
        headerView.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 32/255, alpha: 1)
        return headerView
    }
    
   
    
    
}
