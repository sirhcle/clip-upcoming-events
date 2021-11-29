//
//  CellEvents.swift
//  Clip Upcoming Events
//
//  Created by christian hernandez rivera on 28/11/21.
//

import Foundation
import UIKit

class CellEvents: UITableViewCell {
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDateStart: UILabel!
    @IBOutlet weak var lblDateEnd: UILabel!
    
    var event: Events!
    var sectionEvents: [Events]!
    var currentIndex: Int!
    var isConflicted: Bool! =  false
    
    
    override func prepareForReuse() {
        self.lblEventName.text = ""
        self.lblDateStart.text = ""
        self.lblDateEnd.text = ""
        self.isConflicted = false
        self.backgroundColor = .white
    }
    
    func setupEvent() {
        self.lblEventName.text = event.title
        self.lblDateStart.text = event.start
        self.lblDateEnd.text = event.end
        self.convertToTime()
    }
    
    func convertToTime() {
        self.backgroundColor = .white
        //PRIMERA FECHA
        let currentTime = self.event.start
        let timeToString = String(currentTime ?? "")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let startHour = dateFormatter.date(from: timeToString)
        
        for (index, _) in self.sectionEvents.enumerated() {
            
            if index != self.currentIndex {
                //SEGUNDA FECHA INICIO
                let segundaFechaInicio = self.sectionEvents[index].start
                let timeToString1 = String(segundaFechaInicio ?? "")
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "MMMM dd, yyyy h:mm a"
                //dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
                let startHour1 = dateFormatter1.date(from: timeToString1)
                
                //SEGUNDA FECHA FIN
                let segundaFechaFin = self.sectionEvents[index].end
                let timeToString2 = String(segundaFechaFin ?? "")
                
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "MMMM dd, yyyy h:mm a"
                //dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
                let startHour2 = dateFormatter2.date(from: timeToString2)
                
                if startHour! >= startHour1! && startHour! < startHour2! {
                    self.isConflicted = true
                }
            }
        }
        
        if self.isConflicted {
            self.backgroundColor = .green
        }
    }
}
