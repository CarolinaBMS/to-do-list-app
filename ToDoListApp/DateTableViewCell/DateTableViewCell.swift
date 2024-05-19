//
//  DateTableViewCell.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 04/05/24.
//

import UIKit

protocol DateTableViewCellDelegate {
    func calendarSwitchValueChanged(isOn: Bool)
}

class DateTableViewCell: UITableViewCell {
    var delegate: DateTableViewCellDelegate?
    
    @IBOutlet weak var calendarDatePicker: UIDatePicker!
    @IBOutlet weak var calendarSwitch: UISwitch!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        calendarSwitch.isOn = false
        calendarDatePicker.isHidden = true
        calendarSwitch.addTarget(self, action: #selector(calendarSwitchValueChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func calendarSwitchValueChanged(_ sender: UISwitch) {
        calendarDatePicker.isHidden = !sender.isOn
        delegate?.calendarSwitchValueChanged(isOn: sender.isOn)
    }
    
}
