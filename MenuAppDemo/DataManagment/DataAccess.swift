//
//  DataClient.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

let dataAccess = DataAccess()

class DataAccess {
    private let restDataClient: RestDataClient = RestDataClient()
    
    func userLogin(request: LoginUserRequest, successHandler: ((String) -> Void)? = nil, failHandler: ((String?) -> Void)? = nil) {
        restDataClient.userLogin(request: request, successHandler: successHandler, failHandler: failHandler)
    }
    
    func fetchVenues(request: VenueLocationRequest, successHandler: ((VenuesResponse) -> Void)? = nil, failHandler: ((String?) -> Void)? = nil) {
        restDataClient.fetchVenues(request: request, successHandler: successHandler, failHandler: failHandler)
    }
}
