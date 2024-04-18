//
//  TaskTableViewCell.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 30/03/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var buttonIsChecked = false
    
    @IBOutlet weak var taskListTitleLabel: UILabel!
    
    @IBOutlet weak var taskTimeLabel: UILabel!
    
    @IBOutlet weak var taskCategoryLabel: UILabel!
        
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        buttonIsChecked.toggle()
        
        let buttonImageName = buttonIsChecked ? "checkmark.circle.fill" : "circle"
        let buttonImage = UIImage(systemName: buttonImageName)
        
        checkButtonOutlet.setImage(buttonImage, for: .normal)
    }
   
}
