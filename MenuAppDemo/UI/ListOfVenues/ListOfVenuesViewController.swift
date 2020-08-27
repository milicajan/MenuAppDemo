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
    
    private let titleLabel: UILabel = UILabel()
    private let listOfVenuesTableView: UITableView = UITableView()
    private let refreshControler: UIRefreshControl = UIRefreshControl()
    
    private var venues: [VenueResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        refreshControler.addTarget(self, action: #selector(fetchVenues), for: .valueChanged)
        
        addTitleLabel()
        addTableView()
        
        setupConstraints()
        
        fetchVenues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addTitleLabel() {
        titleLabel.backgroundColor = .white
        titleLabel.text = listOfVenuesTitleLocalizedString
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.customFont(ofSize: FontSizes.title25, type: .bold)
        titleLabel.numberOfLines = 1
        
        view.addSubview(titleLabel)
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
        listOfVenuesTableView.tableFooterView = UIView(frame: .zero)
        listOfVenuesTableView.addSubview(refreshControler)
        
        view.addSubview(listOfVenuesTableView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        listOfVenuesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-Margins.small10)
            make.left.right.equalToSuperview()
        }
    }
    
    @objc private func fetchVenues() {
        self.refreshControler.beginRefreshing()
        
        let request = VenueLocationRequest()
        request.latitude = "44.001783"
        request.longitude = "21.26907"
        
        dataAccess.fetchVenues(request: request, successHandler: { [weak self] (response) in
            guard let self = self else { return }
            
            self.refreshControler.endRefreshing()
            DispatchQueue.main.async {
                self.venues = response.venues
                self.listOfVenuesTableView.reloadData()
            }
        }) { [weak self] (error) in
            guard let self = self else { return }
            
            self.refreshControler.endRefreshing()
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

