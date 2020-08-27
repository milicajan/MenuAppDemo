//
//  RestDataClient.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation
import Alamofire

struct HTTPHeaderFields {
    public static let application = "application"
    public static let contentType = "Content-Type"
    public static let deviceUUID = "Device-UUID"
    public static let apiVersion = "Api-Version"
}

struct MIMETypes {
    public static let json = "application/json"
}

class RestDataClient {
    
    private let baseUrl: String = "https://api-playground.menu.app/api"
    
    private var headers: HTTPHeaders {
        return [
            HTTPHeaderFields.application: "mobile-application",
            HTTPHeaderFields.contentType: MIMETypes.json,
            HTTPHeaderFields.deviceUUID: "123456",
            HTTPHeaderFields.apiVersion: "3.7.0"
        ]
    }
    
    func userLogin(request: LoginUserRequest, successHandler: ((String) -> Void)? = nil, failHandler: ((String?) -> Void)? = nil) {
        let url: String = "\(baseUrl)/customers/login"
        
        AF.request(url,
                   method: .post,
                   parameters: request.toDictionary(),
                   encoding: JSONEncoding.default,
                   headers: headers).validate().responseJSON() { response in
                    
                    print("RESPONSE code: \(response.response?.statusCode ?? -1)")
                    
                    switch response.result {
                    case .success:
                        if let response = response.value as? [String: Any] {
                            let token = LoginUserResponse(response)
                            successHandler?(token.value)
                        }
                        
                    case let .failure(error):
                        failHandler?(error.localizedDescription)
                    }
        }
    }
    
    func fetchVenues(request: VenueLocationRequest, successHandler: ((VenuesResponse) -> Void)? = nil, failHandler: ((String?) -> Void)? = nil) {
        let url: String = "\(baseUrl)/directory/search"
        
        AF.request(url,
                   method: .post,
                   parameters: request.toDictionary(),
                   encoding: JSONEncoding.default,
                   headers: headers).validate().responseJSON() { response in
                    
                    print("RESPONSE code: \(response.response?.statusCode ?? -1)")
                    
                    switch response.result {
                    case .success:
                        if let response = response.value as? [String: Any] {
                            let venues = VenuesResponse(response)
                            successHandler?(venues)
                        }
                        
                    case let .failure(error):
                        failHandler?(error.localizedDescription)
                    }
        }
    }
}
