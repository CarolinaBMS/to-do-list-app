//
//  Todo.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 06/03/24.
//

import Foundation

//class to represent a task.
class Task {
    var title: String
    var dueDate: Date
    
    
    init(title: String, dueDate: Date) {
        self.title = title
        self.dueDate = dueDate
    }
 
}


var tasks: [Task] = [
    Task(title: "Go to supermarket", dueDate: .now ),
    Task(title: "Pay bills", dueDate: .now),
    Task(title: "Make biscuits", dueDate: .now),
]

