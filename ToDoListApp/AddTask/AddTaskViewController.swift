//
//  AddTaskViewController.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 10/04/24.
//

import UIKit

protocol AddTaskDelegate: AnyObject {
    func savedTask(taskTitle: String, taskCategory: String)
}

class AddTaskViewController: UIViewController {
    
    weak var delegate: AddTaskDelegate?

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskCategoryTextField: UITextField!
    
    @IBAction func saveTaskButton(_ sender: UIButton) {
        var titleText = taskTitleTextField.text ??  ""
        if titleText.isEmpty {
            titleText = "New task"
        }
        
        var categoryText = "\(taskCategoryTextField.text ?? "")"
        if categoryText.isEmpty {
            categoryText = "Category"
        }
        
        delegate?.savedTask(taskTitle: titleText, taskCategory: categoryText)
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
