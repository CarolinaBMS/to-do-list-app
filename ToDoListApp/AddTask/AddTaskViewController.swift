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
        let titleText = taskTitleTextField.text ??  "no title text"
        let categoryText = taskCategoryTextField.text ?? "no category text"
        
        delegate?.savedTask(taskTitle: titleText, taskCategory: categoryText)
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
