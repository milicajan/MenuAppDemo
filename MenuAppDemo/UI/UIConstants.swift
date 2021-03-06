//
//  UIConstants.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

struct Margins {
    static let small5: CGFloat = 5.0
    static let small10: CGFloat = 10.0
    static let small20: CGFloat = 20.0
}

struct Sizes {
    static let titleLabelHeight: CGFloat = 25.0
    static let invalidLabelHeight: CGFloat = 20.0
    static let textFieldHeight: CGFloat = 35.0
    static let separatorHeight: CGFloat = 1.0
    static let inputFieldHeight: CGFloat = 70.0
    static let loginButtonHeight: CGFloat = 50.0
    static let screenSize: CGRect = UIScreen.main.bounds
}

struct FontSizes {
    static let title15: CGFloat = 15.0
    static let title20: CGFloat = 20.0
    static let title25: CGFloat = 25.0
}

struct UserDefaultsKeys {
    static let userToken = "userToken"
}
