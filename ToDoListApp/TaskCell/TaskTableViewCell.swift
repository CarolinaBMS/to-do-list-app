//
//  TaskTableViewCell.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 30/03/24.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func taskCheckPressed(buttonIsChecked: Bool, at indexPath: IndexPath)
}

class TaskTableViewCell: UITableViewCell {
    
    weak var delegate: TaskCellDelegate?
    var buttonIsChecked = false
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var taskListTitleLabel: UILabel!
    
    @IBOutlet weak var taskTimeLabel: UILabel!
    
    @IBOutlet weak var taskCategoryLabel: UILabel!
        
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        buttonIsChecked.toggle()
        let buttonImageName = buttonIsChecked ? "checkmark.circle.fill" : "circle"
        let buttonImage = UIImage(systemName: buttonImageName)
        checkButtonOutlet.setImage(buttonImage, for: .normal)
        
        if let indexPath = indexPath {
            delegate?.taskCheckPressed(buttonIsChecked: buttonIsChecked, at: indexPath)
        }
    }
   
}
