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
    
    func configureDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
            
        let taskDate: Date = datePicker
        stringDate = dateFormatter.string(from: taskDate)
    }
}
