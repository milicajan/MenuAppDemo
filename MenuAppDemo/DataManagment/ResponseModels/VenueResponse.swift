//
//  VenueResponse.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import Foundation

private struct VenueResponseKeys {
    static let nameKey = "name"
    static let descriptionKey = "description"
    static let isOpenKey = "is_open"
    static let welcomeMsgKey = "welcome_message"
    static let imageKey = "image"
    static let thumbnailKey = "thumbnail_medium"
}

class VenueResponse {
    var name: String = ""
    var description: String = ""
    var isOpen: Bool = false
    var welcomeMsg: String = ""
    var thumbnail: String = ""
    
    init(_ serializedItem: [String: Any]) {
        if let name = serializedItem[VenueResponseKeys.nameKey] as? String {
            self.name = name
        }
        
        if let description = serializedItem[VenueResponseKeys.descriptionKey] as? String {
            self.description = description
        }
        
        if let welcomeMsg = serializedItem[VenueResponseKeys.welcomeMsgKey] as? String {
            self.welcomeMsg = welcomeMsg
        }
        
        if let image = serializedItem[VenueResponseKeys.imageKey] as? [String: Any] {
            if let thumbnail = image[VenueResponseKeys.thumbnailKey] as? String {
                self.thumbnail = thumbnail
            }
        }
        
        if let isOpen = serializedItem[VenueResponseKeys.isOpenKey] as? Bool {
            self.isOpen = isOpen
        }
    }
}



