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
        // Set data source and delegate for table view
        ToDoListTableView.dataSource = self
        ToDoListTableView.delegate = self
        ToDoListTableView.sectionHeaderTopPadding = 0
    }
    
    
    func configureTableView() {
        // Register custom cell for table view
        ToDoListTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    // Prepare for segue and set delegate for AddTaskViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskSegue" {
            if let addTaskVC = segue.destination as? AddTaskViewController {
                addTaskVC.delegate = self
            }
        }
    }
    
}

extension ViewController: AddTaskDelegate {
    // Method called when task is saved
    func savedTask(taskTitle: String, taskCategory: String) {
        // Add new task to data source and reload table view
        tasks.append(Task(title: taskTitle, category: taskCategory))
        ToDoListTableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    // Configure the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // Create a cell to be displayed according to the tasks created in the 'tasks' array.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            fatalError("error to create TaskTableViewCell")
        }
        
        let task = tasks[indexPath.row]
        
        taskCell.taskListTitleLabel.text = task.title
        taskCell.taskCategoryLabel.text = "\(task.category)"
        
        return taskCell
    }
    
}


extension ViewController: HomeTableViewHeaderDelegate {
    // Show AddTaskViewController
    func didTapAddTaskButton() {
        performSegue(withIdentifier: "addTaskSegue", sender: self)
    }
    
}


extension ViewController: UITableViewDelegate {
    // Method to configure which View will be displayed in the TableView header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader
        
        headerView?.delegate = self

        headerView?.configureDateLabel()
        
        return headerView
    }
    
    // Remove an item from tasks array and the cell
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == . delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // Returns the height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    // Returns the height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
