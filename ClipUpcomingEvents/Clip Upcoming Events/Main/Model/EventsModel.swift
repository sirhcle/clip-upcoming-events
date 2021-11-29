//
//  EventsModel.swift
//  Clip Upcoming Events
//
//  Created by christian hernandez rivera on 28/11/21.
//

import Foundation

struct Events: Codable {
    var title: String?
    var start: String?
    var end: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case start = "start"
        case end = "end"
    }
}




