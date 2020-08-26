
//
//  UserRegisterLogin.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

struct LoginUserRequestKeys {
    static let emailKey: String = "email"
    static let passwordKey: String = "password"
}

class LoginUserRequest {
    var email: String = ""
    var password: String = ""
    
    func toDictionary() -> [String : Any] {
        var returnDictionary: [String: Any] = [:]
        
        returnDictionary.updateValue(self.email, forKey: LoginUserRequestKeys.emailKey)
        returnDictionary.updateValue(self.password, forKey: LoginUserRequestKeys.passwordKey)
        
        return returnDictionary
    }
}

