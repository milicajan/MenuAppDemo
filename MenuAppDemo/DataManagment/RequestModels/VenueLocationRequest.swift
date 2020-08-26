//
//  VenueLocationRequest.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

struct VenueLocationRequestKeys {
    static let latitudeKey: String = "latitude"
    static let longitudeKey: String = "longitude"
}

class VenueLocationRequest {
    var latitude: String = ""
    var longitude: String = ""
    
    func toDictionary() -> [String : Any] {
        var returnDictionary: [String: Any] = [:]
        
        returnDictionary.updateValue(self.latitude, forKey: VenueLocationRequestKeys.latitudeKey)
        returnDictionary.updateValue(self.longitude, forKey: VenueLocationRequestKeys.longitudeKey)
        
        return returnDictionary
    }
}

