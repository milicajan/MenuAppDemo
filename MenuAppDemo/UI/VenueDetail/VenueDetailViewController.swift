//
//  VenueDetailViewController.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

class VenueDetailViewController: BaseViewController {
    
    private let venueImageView: UIImageView = UIImageView()
    private let venueNameLabel: UILabel = UILabel()
    private let welcomeMsgLabel: UILabel = UILabel()
    private let introLabel: UILabel = UILabel()
    private let isOpenLabel: UILabel = UILabel()
    
    var venue: VenueResponse = VenueResponse([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: logoutTitleLocalizedString, style: .plain, target: self, action: #selector(logout))
        
        addVenueImageView()
        addVenueNameLabel()
        addWelcomeMsgLabel()
        addIntroLabel()
        addIsOpenLabel()
        
        setupConstraints()
    }
    
    private func addVenueImageView() {
        venueImageView.setImage(with: venue.thumbnail)
        
        view.addSubview(venueImageView)
    }
    
    private func addVenueNameLabel() {
        venueNameLabel.text = venue.name
        venueNameLabel.textAlignment = .left
        venueNameLabel.textColor = .gray
        
        view.addSubview(venueNameLabel)
    }
    
    private func addWelcomeMsgLabel() {
        welcomeMsgLabel.text = venue.welcomeMsg
        welcomeMsgLabel.textAlignment = .left
        welcomeMsgLabel.textColor = .gray
        
        view.addSubview(welcomeMsgLabel)
    }
    private func addIntroLabel() {
        introLabel.text = venue.description
        introLabel.textAlignment = .left
        introLabel.textColor = .gray
        
        view.addSubview(introLabel)
    }
    
    private func addIsOpenLabel() {
        isOpenLabel.text = venue.isOpen ? openTitleLocalizedString : closedTitleLocalizedString
        isOpenLabel.textAlignment = .left
        isOpenLabel.textColor = .gray
        
        view.addSubview(isOpenLabel)
    }
    
    private func setupConstraints() {
        venueImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(2 * Sizes.screenSize.height / 3)
        }
        
        venueNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(venueImageView.snp.bottom).offset(Margins.small10)
            make.right.equalToSuperview()
        }
        
        welcomeMsgLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(venueNameLabel.snp.bottom).offset(Margins.small10)
            make.right.equalToSuperview()
        }
        
        introLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(welcomeMsgLabel.snp.bottom).offset(Margins.small10)
            make.right.equalToSuperview()
        }
        
        isOpenLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(introLabel.snp.bottom).offset(Margins.small10)
            make.right.equalToSuperview()
        }
    }
    
    @objc func logout() {
        UserDefaults.standard.set(nil, forKey: "userToken")
        self.navigationController?.popToViewController(LoginViewController(), animated: true)
    }
}

extension VenueDetailViewController {
    var logoutTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "logoutTitleLocalizedString", value: "Logout", table: nil)
    }
    
    var openTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "openTitleLocalizedString", value: "Open", table: nil)
    }
    
    var closedTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "closedTitleLocalizedString", value: "Closed", table: nil)
    }
}
