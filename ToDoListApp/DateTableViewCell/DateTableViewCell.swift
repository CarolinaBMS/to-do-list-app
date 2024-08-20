//
//  DateTableViewCell.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 04/05/24.
//

import UIKit

protocol DateTableViewCellDelegate {
    func calendarSwitchValueChanged(isOn: Bool)
    func calendarDateChanged(to date: Date)
}

class DateTableViewCell: UITableViewCell {
    var viewModel: DateViewModel?
    var delegate: DateTableViewCellDelegate?

    @IBOutlet weak var calendarDatePicker: UIDatePicker!
    @IBOutlet weak var calendarSwitch: UISwitch!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        calendarSwitch.isOn = false
        calendarDatePicker.isHidden = true
        calendarDatePicker.minimumDate = .now
        
        calendarSwitch.addTarget(self, action: #selector(calendarSwitchValueChanged(_:)), for: .valueChanged)
        calendarDatePicker.addTarget(self, action: #selector(calendarDatePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func calendarSwitchValueChanged(_ sender: UISwitch) {
        calendarDatePicker.isHidden = !sender.isOn
        delegate?.calendarSwitchValueChanged(isOn: sender.isOn)
    }
    
    @objc func calendarDatePickerValueChanged(_ sender: UIDatePicker) {
        delegate?.calendarDateChanged(to: sender.date)
    }
}
