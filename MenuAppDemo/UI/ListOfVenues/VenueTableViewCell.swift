//
//  VenueTableViewCell.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

private struct VenueTableViewCellKeys {
    static let venueCellIdentifierKey = "venueCell"
}

class VenueTableViewCell: UITableViewCell {
    
    private let venueNameLabel: UILabel = UILabel()
    
    var venueNameText: String = "" {
        didSet {
            venueNameLabel.text = venueNameText
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: VenueTableViewCellKeys.venueCellIdentifierKey)
        accessoryType = .none
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        addVenueNameLabel()
        
        setupConstraints()
    }
    
    private func addVenueNameLabel() {
        venueNameLabel.textColor = .darkGray
        venueNameLabel.textAlignment = .center
        venueNameLabel.font = UIFont.systemFont(ofSize: 25.0)
        venueNameLabel.numberOfLines = 0
        
        addSubview(venueNameLabel)
    }
    
    
    private func setupConstraints() {
        venueNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margins.small20)
            make.right.equalToSuperview().offset(-Margins.small20)
            make.top.equalToSuperview().offset(Margins.small20)
            make.bottom.equalToSuperview().offset(-Margins.small20)
        }
    }
}
