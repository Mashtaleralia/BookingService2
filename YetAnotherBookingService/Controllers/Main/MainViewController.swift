//
//  ViewController.swift
//  YetAnotherBookingService
//
//  Created by Admin on 28.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let style: StyleProvider = Style()
    private let configurator = MainViewConfigurator()
    var presenter: MainViewControllerPresenter!
    
    weak var delegate: TicketSearchViewTextFieldDelegate?
    
    private var collectionView: UICollectionView?
    
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
    
    private let musicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Style().title1
        label.textColor = Style().textColor
        label.text = "Музыкально отлететь"
        return label
    }()
    
    private var ticketSearchView = TicketSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(vc: self, view: ticketSearchView)
        presenter.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(headerLabel)
        view.addSubview(ticketSearchView)
        view.addSubview(musicLabel)
        self.collectionView = setUpCollectionView()
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        delegate?.textFieldSetUp(vc: self)
        addConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { 
            collectionView.reloadData()
        }
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Want some cock?"
        content.body = "Get premium cock with our subscription now!"
        
        let date = Date().addingTimeInterval(8)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { _ in 
            
        }
    }
    
    private func setUpCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(213)))
               
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.5), heightDimension: .absolute(213)), subitem: item, count: 3)
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            let section = NSCollectionLayoutSection(group: group)
            //section.orthogonalScrollingBehavior = .groupPaging
            
            return section
                                              
        })
        
        layout.configuration.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MusicalCollectionViewCell.self, forCellWithReuseIdentifier: MusicalCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        
        return collectionView
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }

        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 100),
            headerLabel.widthAnchor.constraint(equalToConstant: 172),
            ticketSearchView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 35),
            ticketSearchView.heightAnchor.constraint(equalToConstant: 90),
            ticketSearchView.widthAnchor.constraint(equalToConstant: 296),
            ticketSearchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicLabel.topAnchor.constraint(equalTo: ticketSearchView.bottomAnchor, constant: 25),
            musicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            musicLabel.heightAnchor.constraint(equalToConstant: 26),
            collectionView.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }

}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        var bottomText = ""
//        var topText = ""
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()

        } else {
            textField.resignFirstResponder()
        }
//
//        print(topText)
//        print(bottomText)
     
        return true
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfOffers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicalCollectionViewCell.identifier, for: indexPath) as? MusicalCollectionViewCell else {
            fatalError()
        }
        presenter.configure(cell: cell, at: indexPath.row)
        return cell
    }
    
}

extension MainViewController: TicketSearchViewNavigationDelegate {
    func jumpTo() {
        presenter.jumpToSearch()
    }
    
    
}
