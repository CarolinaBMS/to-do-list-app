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
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var sideMenuButtonOutlet: UIButton!
    
    @IBOutlet weak var addTaskButtonOutlet: UIButton!
    
    
    @IBAction func sideMenu(_ sender: Any) {
        print("side mennu tapped")
    }
    
    
    //Add a new task in the list
    @IBAction func addTask(_ sender: UIButton) {
        delegate?.didTapAddTaskButton()
    }
    
    
    func configureDateLabel() {
        //date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        
        let today: Date = .now
        let dateString = dateFormatter.string(from: today)
        
        dateLabel.text = dateString
    }
    
    
}
