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
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        venueNameLabel.font = UIFont.customFont(ofSize: FontSizes.title15, type: .bold)
        venueNameLabel.numberOfLines = 1
        venueNameLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(venueNameLabel)
    }
    
    private func addWelcomeMsgLabel() {
        welcomeMsgLabel.text = venue.welcomeMsg
        welcomeMsgLabel.textAlignment = .left
        welcomeMsgLabel.textColor = .gray
        welcomeMsgLabel.font = UIFont.customFont(ofSize: FontSizes.title15, type: .bold)
        welcomeMsgLabel.numberOfLines = 3
        welcomeMsgLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(welcomeMsgLabel)
    }
    private func addIntroLabel() {
        introLabel.text = venue.description
        introLabel.textAlignment = .left
        introLabel.textColor = .gray
        introLabel.font = UIFont.customFont(ofSize: FontSizes.title15, type: .bold)
        introLabel.numberOfLines = 3
        introLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(introLabel)
    }
    
    private func addIsOpenLabel() {
        isOpenLabel.text = venue.isOpen ? openTitleLocalizedString : closedTitleLocalizedString
        isOpenLabel.textAlignment = .left
        isOpenLabel.textColor = .gray
        isOpenLabel.font = UIFont.customFont(ofSize: FontSizes.title15, type: .bold)
        isOpenLabel.numberOfLines = 1
        isOpenLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(isOpenLabel)
    }
    
    private func setupConstraints() {
        venueImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(2 * Sizes.screenSize.height / 3)
        }
        
        venueNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(Margins.small10)
            if venue.thumbnail.isEmpty {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(venueImageView.snp.bottom).offset(Margins.small5)
            }
        }
        
        welcomeMsgLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(Margins.small10)
            make.top.equalTo(venueNameLabel.snp.bottom).offset(Margins.small5)
        }
        
        introLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(Margins.small10)
            make.top.equalTo(welcomeMsgLabel.snp.bottom).offset(Margins.small5)
        }
        
        isOpenLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(Margins.small10)
            make.top.equalTo(introLabel.snp.bottom).offset(Margins.small5)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func logout() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.userToken)
        if let _ = navigationController?.viewControllers.first as? LoginViewController {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
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
