//
//  TextFieldViewModel.swift
//  ToDoListApp
//
//  Created by Carolina Bortoli M.S on 18/05/24.
//

import Foundation

class TextFieldViewModel {
    var placeholder: String
    var text: String = ""
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
}
