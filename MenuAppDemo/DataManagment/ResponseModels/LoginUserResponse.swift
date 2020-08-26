//
//  LoginResponse.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

private struct LoginUserResponseKeys {
    static let dataKey = "data"
    static let tokenKey = "token"
    static let valueKey = "value"
}

class LoginUserResponse {
    var value: String = ""
    
    init(_ serializedItem: [String: Any]) {
        if let data = serializedItem[LoginUserResponseKeys.dataKey] as? [String: Any] {
            if let token = data[LoginUserResponseKeys.tokenKey] as? [String: Any] {
                if let value = token[LoginUserResponseKeys.valueKey] as? String {
                    self.value = value
                }
            }
        }
    }
}


