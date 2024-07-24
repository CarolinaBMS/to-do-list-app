//
//  TextFieldTableViewCell.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 04/05/24.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
   
    var viewModel: TextFieldViewModel?
    
    @IBOutlet weak var taskTextField: UITextField!
    
    override func awakeFromNib() {
        taskTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func configure(with viewModel: TextFieldViewModel) {
        self.viewModel = viewModel
        taskTextField.placeholder = viewModel.placeholder
        taskTextField.text = viewModel.text
    }
    
    @objc func textFieldDidChange() {
        viewModel?.text = taskTextField.text ?? ""
    }
    
}
