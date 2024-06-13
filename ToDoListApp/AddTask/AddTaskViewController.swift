//
//  AddTaskViewController.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 10/04/24.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func didSaveTask(_ task: Task)
}

class AddTaskViewController: UIViewController {
    
    var viewModel = AddTaskViewModel()
    weak var delegate: AddTaskViewControllerDelegate?
    
    var calendarSwitchIsOn = false
    var hourSwitchIsOn = false

    @IBOutlet weak var addNewTaskTableView: UITableView!
    
    @IBAction func saveTaskButton(_ sender: UIButton) {
        viewModel.saveTask()
        if let task = viewModel.getTask() {
            delegate?.didSaveTask(task)
        }
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNewTaskTableView.dataSource = self
        addNewTaskTableView.delegate = self
        
        configureAddNewTaskTableView()
    }

    func configureAddNewTaskTableView() {
        addNewTaskTableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
        addNewTaskTableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateTableViewCell")
        addNewTaskTableView.register(UINib(nibName: "HourTableViewCell", bundle: nil), forCellReuseIdentifier: "HourTableViewCell")
    }
}


extension AddTaskViewController: DateTableViewCellDelegate {
    func calendarSwitchValueChanged(isOn: Bool) {
        calendarSwitchIsOn = isOn
        addNewTaskTableView.reloadData()
    }
    
    func calendarDateChanged(to date: Date) {
        viewModel.taskDateViewModel.datePicker = date
        viewModel.taskDateViewModel.configureDate()
    }

}


extension AddTaskViewController: UITableViewDataSource {
    enum Section: Int, CaseIterable {
        case textField
        case date
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Section.textField.rawValue ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Invalid section") }
        
        switch section {
        case .textField:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            let cellViewModel = indexPath.row == 0 ? viewModel.taskNameViewModel : viewModel.taskCategoryViewModel
            cell.configure(with: cellViewModel)
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
}


extension AddTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Invalid section") }
        
        switch section {
        case .textField:
            return 65
        case .date:
            return calendarSwitchIsOn == true ? 425 : 60
        }
    }
    
}



