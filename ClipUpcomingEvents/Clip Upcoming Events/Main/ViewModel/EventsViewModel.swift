//
//  EventsViewModel.swift
//  Clip Upcoming Events
//
//  Created by christian hernandez rivera on 28/11/21.
//

import Foundation

class EventsViewModel {
    var refreshData = { () -> () in }
    
    var eventsModel: [Events] = [Events]() {
        didSet {
            self.refreshData()
        }
    }
    
    func getAllEvents() {
        WSInstance.getAllEvents { (dataResponse:[Events]) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { //Emulate WS time response
                self.eventsModel = dataResponse
            }
        }
    }
}
