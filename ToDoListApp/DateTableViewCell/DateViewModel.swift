//
//  DateViewModel.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 20/05/24.
//

import Foundation

class DateViewModel {
    var datePicker: Date = Date()
    var stringDate: String = ""
    
    func configureDateAsString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
            
        stringDate = dateFormatter.string(from: datePicker)
    }
    
    func configureStringDateInCalendarDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        datePicker = dateFormatter.date(from: stringDate) ?? .now
    }
    
}
