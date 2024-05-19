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
    
    private var task: Task?
    
    func saveTask() {
        task = Task(name: taskNameViewModel.text, category: taskCategoryViewModel.text)
    }
    
    func getTask() -> Task? {
        return task
    }
}
