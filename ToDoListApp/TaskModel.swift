//
//  Todo.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 06/03/24.
//

import Foundation

struct Task: Codable {
    var name: String
    var category: String
    var dueDate: String
    var isCompleted: Bool
}
