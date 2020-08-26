//
//  UIViewExtension.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

extension UIView {
    private static var tapKey = "tapKey"
    
    func addTap(numberOfTapsRequired: Int = 1, numberOfTouchesRequired: Int = 1, cancelTouchesInView: Bool = true, action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        objc_setAssociatedObject(self, &UIView.tapKey, TapAction(action: action), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView))
        tapRecognizer.numberOfTapsRequired = numberOfTapsRequired
        tapRecognizer.numberOfTouchesRequired = numberOfTouchesRequired
        tapRecognizer.cancelsTouchesInView = cancelTouchesInView
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func tapView() {
        if let tap = objc_getAssociatedObject(self, &UIView.tapKey) as? TapAction {
            tap.action()
        }
    }
    
    private class TapAction {
        var action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
    }
}
