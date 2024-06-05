//
//  HomeTableViewHeader.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 16/03/24.
//

import UIKit

protocol HomeTableViewHeaderDelegate: AnyObject {
    func didTapAddTaskButton()
}

class HomeTableViewHeader: UIView {
    
    weak var delegate: HomeTableViewHeaderDelegate?
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var addTaskButtonOutlet: UIButton!
    
    //Add a new task in the list
    @IBAction func addTask(_ sender: UIButton) {
        delegate?.didTapAddTaskButton()
    }
    
}
