//
//  UIFontExtension.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 27/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

enum FontType {
    case bold
    case light
    case regular
}

extension UIFont {
    class func customFont(ofSize fontSize: CGFloat, type: FontType) -> UIFont? {
        switch type {
        case .bold:
            return UIFont(name: "Roboto-Bold", size: fontSize)
        case .light:
            return UIFont(name: "Roboto-Light", size: fontSize)
        case .regular:
            return UIFont(name: "Roboto-Regular", size: fontSize)
        }
    }
}

