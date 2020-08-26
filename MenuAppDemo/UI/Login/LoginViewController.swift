//
//  ViewController.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private let passwordTextField: MenuInputField = MenuInputField()
    private let emailTextField: MenuInputField = MenuInputField()
    private let loginButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = loginTitleLocalizedString
        self.view.backgroundColor = .white
        
        addEmailTextField()
        addPasswordTextField()
        addLoginButton()
        
        setupConstraints()
    }
    
    private func addEmailTextField() {
        emailTextField.titleString = emailTitleLocalizedString
        emailTextField.delegate = self
        emailTextField.textFieldPlaceholder = emailTitleLocalizedString
        emailTextField.hideTitleLabel = true
        emailTextField.separatorColor = .gray
        emailTextField.textField.keyboardType = .URL
        emailTextField.textField.textContentType = .emailAddress
        
        view.addSubview(emailTextField)
    }
    
    private func addPasswordTextField() {
        passwordTextField.titleString = passwordTitleLocalizedString
        passwordTextField.textFieldPlaceholder = passwordTitleLocalizedString
        passwordTextField.hideTitleLabel = true
        passwordTextField.delegate = self
        passwordTextField.separatorColor = .gray
        passwordTextField.textField.isSecureTextEntry = true
        passwordTextField.textField.returnKeyType = .done
        passwordTextField.textField.textContentType = .password
        
        view.addSubview(passwordTextField)
    }
    
    private func addLoginButton() {
        loginButton.backgroundColor = .blue
        loginButton.setTitle(loginTitleLocalizedString, for: .normal)
        loginButton.addTap {
            self.login()
        }
        
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        emailTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margins.small10)
            make.right.equalToSuperview().offset(-Margins.small10)
            make.centerY.equalToSuperview().offset(-2 * Margins.small20)
            make.height.equalTo(70.0)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margins.small10)
            make.right.equalToSuperview().offset(-Margins.small10)
            make.top.equalTo(emailTextField.snp.bottom).offset(Margins.small10)
            make.height.equalTo(70.0)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margins.small10)
            make.right.equalToSuperview().offset(-Margins.small10)
            make.height.equalTo(50.0)
            make.top.equalTo(passwordTextField.snp.bottom).offset(2 * Margins.small20)
        }
    }
    
    func login() {
        self.presentLoader()
        
        let userLoginRequest: LoginUserRequest = LoginUserRequest()
        userLoginRequest.email = "test@testmenu.app"
        userLoginRequest.password = "test1234"
        
        dataAccess.userLogin(request: userLoginRequest, successHandler: { (token) in
            UserDefaults.standard.set(token, forKey: "userToken")
            self.fetchVenues()
        }) { (error) in
            self.dismissLoader()
            
            self.showError(message: "Something went wrong. Please, try again! \(error ?? "")")
        }
    }
    
    private func fetchVenues() {
        let request = VenueLocationRequest()
        request.latitude = "44.001783"
        request.longitude = "21.26907"
        
        dataAccess.fetchVenues(request: request, successHandler: { (response) in
            self.dismissLoader()
            DispatchQueue.main.async {
                let listOfVenuesVC = ListOfVenuesViewController()
                listOfVenuesVC.venues = response.venues
                self.navigationController?.pushViewController(listOfVenuesVC, animated: true)
            }
        }) { (error) in
            self.dismissLoader()
            
            self.showError(message: "Something went wrong. Please, try again! \(error ?? "")")
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}

extension LoginViewController {
    var emailTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "emailTitleLocalizedString", value: "Email", table: nil)
    }
    
    var passwordTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "passwordTitleLocalizedString", value: "Password", table: nil)
    }
    
    var loginTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "loginTitleLocalizedString", value: "Login", table: nil)
    }
}
