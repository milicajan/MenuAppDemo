//
//  ListOfVenuesViewController.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

private struct ListOfVenuesViewControllerKeys {
    static let venueCellIdentifierKey = "venueCell"
}

class ListOfVenuesViewController: BaseViewController {
    
    private let listOfVenuesTableView: UITableView = UITableView()
    
    var venues: [VenueResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = listOfVenuesTitleLocalizedString
        
        addTableView()
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchVenues()
    }
    
    private func addTableView() {
        listOfVenuesTableView.delegate = self
        listOfVenuesTableView.dataSource = self
        listOfVenuesTableView.separatorStyle = .singleLine
        listOfVenuesTableView.separatorColor = .lightGray
        listOfVenuesTableView.showsVerticalScrollIndicator = false
        listOfVenuesTableView.rowHeight = UITableView.automaticDimension
        listOfVenuesTableView.estimatedRowHeight = 70.0
        listOfVenuesTableView.translatesAutoresizingMaskIntoConstraints = true
        listOfVenuesTableView.register(VenueTableViewCell.self, forCellReuseIdentifier: ListOfVenuesViewControllerKeys.venueCellIdentifierKey)
        listOfVenuesTableView.layoutMargins = UIEdgeInsets.zero
        listOfVenuesTableView.separatorInset = UIEdgeInsets.zero
        
        view.addSubview(listOfVenuesTableView)
    }
    
    private func setupConstraints() {
        listOfVenuesTableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func fetchVenues() {
        self.presentLoader()
        
        let request = VenueLocationRequest()
        request.latitude = "44.001783"
        request.longitude = "21.26907"
        
        dataAccess.fetchVenues(request: request, successHandler: { (response) in
            self.dismissLoader()
            
            DispatchQueue.main.async {
                self.venues = response.venues
                self.listOfVenuesTableView.reloadData()
            }
        }) { (error) in
            self.dismissLoader()
            
            self.showError(message: "Something went wrong. Please, try again! \(error ?? "")")
        }
    }
}

extension ListOfVenuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListOfVenuesViewControllerKeys.venueCellIdentifierKey, for: indexPath)
        
        guard let venueCell = cell as? VenueTableViewCell else {
            return cell
        }
        
        venueCell.venueNameText = venues[indexPath.row].name
        
        return venueCell
    }
}

extension ListOfVenuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let venueDetailVC = VenueDetailViewController()
            venueDetailVC.venue = self.venues[indexPath.row]
            self.navigationController?.pushViewController(venueDetailVC, animated: true)
        }
    }
}

extension ListOfVenuesViewController {
    var listOfVenuesTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "listOfVenuesTitleLocalizedString", value: "List of Venues", table: nil)
    }
}

