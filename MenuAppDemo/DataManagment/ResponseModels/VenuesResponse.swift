//
//  VenuesResponse.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

private struct VenuesKeys {
    static let dataKey = "data"
    static let venuesKey = "venues"
    static let venueKey = "venue"
}

class VenuesResponse {
    var venues: [VenueResponse] = []
    
    init(_ serializedItem: [String: Any]) {
        if let data = serializedItem[VenuesKeys.dataKey] as? [String: Any] {
            if let venues = data[VenuesKeys.venuesKey] as? [[String: Any]] {
                for venue in venues {
                    if let venue = venue[VenuesKeys.venueKey] as? [String: Any] {
                        self.venues.append(VenueResponse(venue))
                    }
                }
            }
        }
    }
}


