//
//  ViewController.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UIScrollViewDelegate {
    
    private let containerScrollView: UIScrollView = UIScrollView()
    private let passwordTextField: MenuInputField = MenuInputField()
    private let emailTextField: MenuInputField = MenuInputField()
    private let loginButton: UIButton = UIButton()
    
    private var shouldScroll: Bool = false
    private var activeTextField: MenuInputField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        addContainerScrollView()
        addEmailTextField()
        addPasswordTextField()
        addLoginButton()
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        containerScrollView.contentSize = CGSize(width: Sizes.screenSize.width, height: Sizes.screenSize.height)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        emailTextField.emptyInputData()
        passwordTextField.emptyInputData()
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addContainerScrollView() {
        containerScrollView.delegate = self
        containerScrollView.isScrollEnabled = false
        containerScrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(containerScrollView)
    }
    
    private func addEmailTextField() {
        emailTextField.titleString = emailTitleLocalizedString
        emailTextField.delegate = self
        emailTextField.textFieldPlaceholder = emailTitleLocalizedString
        emailTextField.hideTitleLabel = true
        emailTextField.separatorColor = .gray
        emailTextField.textField.keyboardType = .URL
        emailTextField.textField.textContentType = .emailAddress
        
        containerScrollView.addSubview(emailTextField)
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
        
        containerScrollView.addSubview(passwordTextField)
    }
    
    private func addLoginButton() {
        loginButton.backgroundColor = .lightGray
        loginButton.setTitle(loginTitleLocalizedString, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTap {
            self.validateInputData()
        }
        
        containerScrollView.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        containerScrollView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.width.equalTo(Sizes.screenSize.width - (2 * Margins.small10))
            make.centerY.equalToSuperview().offset(-2 * Margins.small20)
            make.centerX.equalToSuperview()
            make.height.equalTo(Sizes.inputFieldHeight)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(Sizes.screenSize.width - (2 * Margins.small10))
            make.top.equalTo(emailTextField.snp.bottom).offset(Margins.small10)
            make.height.equalTo(Sizes.inputFieldHeight)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(Sizes.screenSize.width - (2 * Margins.small10))
            make.height.equalTo(Sizes.loginButtonHeight)
            make.top.equalTo(passwordTextField.snp.bottom).offset(2 * Margins.small20)
        }
    }
    
    private func validateInputData() {
        if let email = emailTextField.textField.text,
            let password = self.passwordTextField.textField.text {
            emailTextField.invalidLabelHidden = !email.isEmpty
            passwordTextField.invalidLabelHidden = !password.isEmpty
            
            if !email.isEmpty && !password.isEmpty {
                login(with: email, and: password)
            }
        }
    }
    
    private func login(with email: String, and password: String) {
        self.presentLoader()
        
        let userLoginRequest: LoginUserRequest = LoginUserRequest()
        userLoginRequest.email = email
        userLoginRequest.password = password
        
        dataAccess.userLogin(request: userLoginRequest, successHandler: { [weak self] (token) in
            guard let self = self else { return }
            
            self.dismissLoader()
            UserDefaults.standard.set(token, forKey: UserDefaultsKeys.userToken)
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(ListOfVenuesViewController(), animated: true)
            }
        }) { [weak self] (error) in
            guard let self = self else { return }
            
            self.dismissLoader()
            
            self.showError(message: "Something went wrong. Please, try again! \(error ?? "")")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            containerScrollView.isScrollEnabled = true
            let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            containerScrollView.contentInset = contentInsets
            containerScrollView.scrollIndicatorInsets = contentInsets
            
            var aRect: CGRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            
            if let activeTextField = activeTextField, !aRect.contains(activeTextField.frame.origin) {
                self.containerScrollView.scrollRectToVisible(activeTextField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        containerScrollView.contentInset = contentInsets
        containerScrollView.scrollIndicatorInsets = contentInsets
        containerScrollView.isScrollEnabled = false
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField.textField {
            activeTextField = emailTextField
            emailTextField.editingTextField()
        } else if textField == passwordTextField.textField {
            activeTextField = passwordTextField
            passwordTextField.editingTextField()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField.textField {
            emailTextField.separatorColor = .gray
        } else if textField == passwordTextField.textField {
            passwordTextField.separatorColor = .gray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField = nil
        switch textField {
        case emailTextField.textField:
            passwordTextField.textField.becomeFirstResponder()
        case passwordTextField.textField:
            passwordTextField.textField.resignFirstResponder()
            self.validateInputData()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
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
