//
//  AddTaskViewModel.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 17/05/24.
//

import Foundation

class AddTaskViewModel {
    var taskNameViewModel = TextFieldViewModel(placeholder: "Add task name")
    var taskCategoryViewModel = TextFieldViewModel(placeholder: "Add task category")
    var taskDateViewModel = DateViewModel()
    private var task: Task?
    
    func saveTask() {
        if taskNameViewModel.text.isEmpty {
            return
        }
        
        if taskDateViewModel.stringDate.isEmpty {
            taskDateViewModel.datePicker = .now
            taskDateViewModel.configureDateAsString()
        }
        
        task = Task(name: taskNameViewModel.text, category: taskCategoryViewModel.text, dueDate: taskDateViewModel.stringDate, isCompleted: false)
    }
    
    func getTask() -> Task? {
        return task
    }
}
