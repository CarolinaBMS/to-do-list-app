//
//  AddTaskViewController.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 10/04/24.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func didSaveTask(_ task: Task)
    func didUpdateTask(_ task: Task, at index: Int)
}

class AddTaskViewController: UIViewController {
    
    var viewModel = AddTaskViewModel()
    weak var delegate: AddTaskViewControllerDelegate?
    
    var calendarSwitchIsOn = false
    var taskToEdit: Task?
    var taskIndex: Int?

    @IBOutlet weak var addNewTaskTableView: UITableView!
    
    @IBAction func saveTaskButton(_ sender: UIButton) {
        saveTask()
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureViewForEditing()
    }

    private func setupTableView() {
        addNewTaskTableView.dataSource = self
        addNewTaskTableView.delegate = self
        addNewTaskTableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
        addNewTaskTableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateTableViewCell")
    }
    
    private func configureViewForEditing() {
        guard let taskToEdit = taskToEdit else { return }
        viewModel.taskNameViewModel.text = taskToEdit.name
        viewModel.taskCategoryViewModel.text = taskToEdit.category
        calendarSwitchIsOn = true
        viewModel.taskDateViewModel.stringDate = taskToEdit.dueDate
        viewModel.taskDateViewModel.configureStringDateInCalendarDate()
    }
    
    private func saveTask() {
        viewModel.saveTask()
        if let taskIndex = taskIndex, let updatedTask = viewModel.getTask() {
            delegate?.didUpdateTask(updatedTask, at: taskIndex)
        } else if let task = viewModel.getTask() {
            delegate?.didSaveTask(task)
        }
        taskToEdit = nil
    }
}


extension AddTaskViewController: DateTableViewCellDelegate {
    func calendarSwitchValueChanged(isOn: Bool) {
        calendarSwitchIsOn = isOn
        addNewTaskTableView.reloadData()
    }
    
    func calendarDateChanged(to date: Date) {
        viewModel.taskDateViewModel.datePicker = date
        viewModel.taskDateViewModel.configureDateAsString()
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
            cell.taskTextField.delegate = self
            cell.taskTextField.tag = indexPath.row
            cell.taskTextField.returnKeyType = indexPath.row == 0 ? .next : .done
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            cell.delegate = self
            if calendarSwitchIsOn == true {
                cell.calendarSwitch.isOn = true
                cell.calendarDatePicker.isHidden = false
                cell.calendarDatePicker.date = viewModel.taskDateViewModel.datePicker
            }
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


extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextCell = addNewTaskTableView.cellForRow(at: IndexPath(row: nextTag, section: 0)) as? TextFieldTableViewCell,
            let nextResponder = nextCell.taskTextField {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}


