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
    var category: String
    
    
    init(title: String, category: String) {
        self.title = title
        self.category = category
    }
 
}


var tasks: [Task] = [
    Task(title: "Go to supermarket", category: "Shopping"),
    Task(title: "Pay bills", category: "Finance"),
    Task(title: "Make biscuits", category: "Food"),
]

