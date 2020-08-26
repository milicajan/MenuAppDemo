//
//  BaseViewController.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController{
    
    var progressHud: MBProgressHUD?
    
    func presentLoader() {
        DispatchQueue.main.async {
            if self.progressHud == nil {
                self.progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
                if let hud = self.progressHud {
                    hud.minSize = CGSize(width: 100, height: 100)
                    hud.bezelView.backgroundColor = .white
                    hud.bezelView.color = .white
                    hud.bezelView.style = .solidColor
                    hud.contentColor = UIColor.blue
                    hud.label.text = self.loadingMessageTitleLocalizedString
                    hud.label.textColor = UIColor.blue
                    hud.detailsLabel.text = self.waitMessageTitleLocalizedString
                    hud.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.progressHud = nil
        }
    }
    
    func showError(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: errorLocalizedString, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okLocalizedString, style: .cancel, handler: { _ in
            completion?()
        }))
        
        present(alert, animated: true, completion: completion)
    }
}

extension BaseViewController {
    var loadingMessageTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "loadingMessageLocalizedString", value: "Loading...", table: nil)
    }
    
    var waitMessageTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "waitMessageLocalizedString", value: "Please Wait", table: nil)
    }
    
    var okLocalizedString: String {
        return Bundle.main.localizedString(forKey: "okayLocalizedString", value: "OK", table: nil)
    }
    
    var errorLocalizedString: String {
        return Bundle.main.localizedString(forKey: "errorMessageLocalizedString", value: "Error", table: nil)
    }
}
