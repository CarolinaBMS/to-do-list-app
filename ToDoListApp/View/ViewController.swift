//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 02/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ToDoListTableView: UITableView!
    
    var tasks: [Task] = [
        Task(name: "Go to supermarket", category: "Shopping"),
        Task(name: "Pay bills", category: "Finance"),
        Task(name: "Make biscuits", category: "Food")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        ToDoListTableView.dataSource = self
        ToDoListTableView.delegate = self
        ToDoListTableView.sectionHeaderTopPadding = 0
    }
    
    func configureTableView() {
        ToDoListTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskSegue" {
            let destinationVC = segue.destination as! AddTaskViewController
            destinationVC.delegate = self
        }
    }
    
}


extension ViewController: HomeTableViewHeaderDelegate {
    func didTapAddTaskButton() {
        performSegue(withIdentifier: "addTaskSegue", sender: self)
    }
    
}

extension ViewController: AddTaskViewControllerDelegate {
    func didSaveTask(_ task: Task) {
        tasks.append(task)
        ToDoListTableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            fatalError("error to create TaskTableViewCell")
        }
        
        let task = tasks[indexPath.row]
        
        taskCell.taskListTitleLabel.text = task.name
        taskCell.taskCategoryLabel.text = task.category
        return taskCell
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader
        
        headerView?.delegate = self

        headerView?.configureDateLabel()
        
        return headerView
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
