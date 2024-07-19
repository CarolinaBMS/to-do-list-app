//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 02/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ToDoListTableView: UITableView!
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        ToDoListTableView.dataSource = self
        ToDoListTableView.delegate = self
        tasks = loadTasksData()
        ToDoListTableView.sectionHeaderTopPadding = 0
        ToDoListTableView.rowHeight = UITableView.automaticDimension
        ToDoListTableView.estimatedRowHeight = 100
    }
    
    func saveTasksData(tasks: [Task]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
    
    func loadTasksData() -> [Task] {
        if let savedTasks = UserDefaults.standard.data(forKey: "tasks") {
            let decoder = JSONDecoder()
            if let loadedTasks = try? decoder.decode([Task].self, from: savedTasks) {
                return loadedTasks
            }
        }
        return []
    }
    
    func configureTableView() {
        ToDoListTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskSegue" {
            let destinationVC = segue.destination as! AddTaskViewController
            destinationVC.delegate = self
            
            if let taskToEdit = sender as? (Task, Int) {
                destinationVC.taskToEdit = taskToEdit.0
                destinationVC.taskIndex = taskToEdit.1
            }
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
        saveTasksData(tasks: tasks)
        ToDoListTableView.reloadData()
    }
    
    func didUpdateTask(_ task: Task, at index: Int) {
        tasks[index] = task
        saveTasksData(tasks: tasks)
        ToDoListTableView.reloadData()
    }
}


extension ViewController: TaskCellDelegate {
    func taskCheckPressed(buttonIsChecked: Bool, at indexPath: IndexPath) {
        tasks[indexPath.row].isCompleted = buttonIsChecked
        saveTasksData(tasks: tasks)
        ToDoListTableView.reloadRows(at: [indexPath], with: .none)
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
        taskCell.taskCategoryLabel.text = "#\(task.category)"
        if task.category.isEmpty {
            taskCell.taskCategoryLabel.text = ""
        }
        taskCell.taskTimeLabel.text = task.dueDate
        
        let buttonImageName = task.isCompleted ? "checkmark.circle.fill" : "circle"
        let buttonImage = UIImage(systemName: buttonImageName)
        taskCell.checkButtonOutlet.setImage(buttonImage, for: .normal)
        taskCell.buttonIsChecked = task.isCompleted
        
        taskCell.delegate = self
        taskCell.indexPath = indexPath
        
        return taskCell
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader
        
        headerView?.delegate = self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
        performSegue(withIdentifier: "addTaskSegue", sender: (selectedTask, indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            saveTasksData(tasks: tasks)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 78
    }
    
}
