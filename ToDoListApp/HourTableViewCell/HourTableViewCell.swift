//
//  HourTableViewCell.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 04/05/24.
//

import UIKit

protocol HourTableViewCellDelegate {
    func hourSwitchValueChanged(isOn: Bool)
}

class HourTableViewCell: UITableViewCell {
    var delegate: HourTableViewCellDelegate?

    @IBOutlet weak var hourDatePicker: UIDatePicker!
    @IBOutlet weak var hourSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        hourSwitch.isOn = false
        hourDatePicker.isHidden = true
        hourSwitch.addTarget(self, action: #selector(hourSwitchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func hourSwitchValueChanged(_ sender: UISwitch) {
        hourDatePicker.isHidden = !sender.isOn
        delegate?.hourSwitchValueChanged(isOn: sender.isOn)
    }
    
}
