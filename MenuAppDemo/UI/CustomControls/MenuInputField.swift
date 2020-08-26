//
//  MenuInputField.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

class MenuInputField: UIView {
    
    private let titleLabel: UILabel = UILabel()
    let textField: UITextField = UITextField()
    private let invalidLabel: UILabel = UILabel()
    private let separator: UIView = UIView()
    
    var textFieldPlaceholder: String = "" {
        didSet {
            textField.placeholder = textFieldPlaceholder
        }
    }
    
    var titleString: String = "" {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    var hideTitleLabel: Bool = true {
        didSet {
            titleLabel.isHidden = hideTitleLabel
        }
    }
    
    var invalidLabelHidden: Bool = true {
        didSet {
            invalidLabel.isHidden = invalidLabelHidden
            separator.backgroundColor = invalidLabelHidden ? .blue : .red
        }
    }
    
    var separatorColor: UIColor = .gray {
        didSet {
            separator.backgroundColor = separatorColor
        }
    }
    
    var delegate: UITextFieldDelegate? = nil {
        didSet {
            textField.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        addInvalidLabel()
        addTitleLabel()
        addTextField()
        addSeparator()
        
        setupConstraints()
    }
    
    private func addInvalidLabel() {
        invalidLabel.textColor = UIColor.red
        invalidLabel.textAlignment = .left
        // invalidLabel.font = UIFont.customFont(ofSize: FontSizes.title13, type: .light)
        invalidLabel.isHidden = true
        invalidLabel.text = requiredTitleLocalizedString
        
        addSubview(invalidLabel)
    }
    
    private func addTitleLabel() {
        titleLabel.textAlignment = .left
        //titleLabel.font = UIFont.customFont(ofSize: FontSizes.title13, type: .light)
        titleLabel.textColor = .blue
        
        addSubview(titleLabel)
    }
    
    private func addTextField() {
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = .gray
        //textField.font = UIFont.customFont(ofSize: FontSizes.title18, type: .light)
        
        addSubview(textField)
    }
    
    private func addSeparator() {
        separator.backgroundColor = .gray
        
        addSubview(separator)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(Margins.small5)
            make.right.equalToSuperview().offset(-Margins.small5)
            make.height.equalTo(Sizes.titleLabelHeight)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().offset(Margins.small5)
            make.right.equalToSuperview().offset(-Margins.small5)
            make.height.equalTo(Sizes.textFieldHeight)
        }
        
        invalidLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separator.snp.top)
            make.left.equalToSuperview().offset(Margins.small5)
            make.right.equalToSuperview().offset(-Margins.small5)
            make.height.equalTo(Sizes.invalidLabelHeight)
        }
        
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(Sizes.separatorHeight)
            make.left.equalToSuperview().offset(Margins.small5)
            make.right.equalToSuperview().offset(-Margins.small5)
        }
    }
}

extension MenuInputField {
    var requiredTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "requiredTitleLocalizedString", value: "This field is required.", table: nil)
    }
}
