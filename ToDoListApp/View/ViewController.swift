//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 02/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ToDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        ToDoListTableView.dataSource = self
        ToDoListTableView.delegate = self
        ToDoListTableView.sectionHeaderTopPadding = 0
        
    }
    
    func configureTableView() {
        ToDoListTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }

}



extension ViewController: UITableViewDataSource {
    //Configure the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //Create a cell to be displayed according to the tasks created in the 'tasks' array.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            fatalError("error to create TaskTableViewCell")
        }
        
        let task = tasks[indexPath.row]
        
        taskCell.taskListTitleLabel.text = task.title
        
        return taskCell
    }
    
}


extension ViewController: HomeTableViewHeaderDelegate {
    //show AddTaskViewController
    func didTapAddTaskButton() {
        performSegue(withIdentifier: "addTaskSegue", sender: nil)
    }
    
}


extension ViewController: UITableViewDelegate {
    //Method to configure which View will be displayed in the TableView header.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader
        
        headerView?.delegate = self

        headerView?.configureDateLabel()
        
        return headerView
    }
    
    
    //Returns the height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
