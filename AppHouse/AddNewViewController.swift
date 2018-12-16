//
//  AddNewViewController.swift
//  App для домашних дел
//
//  Created by Анна on 27.09.18.
//  Copyright © 2018 Анна. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController, UITextFieldDelegate {
    
    var onNewItemAdded: ((String) -> Void)?
    
    @IBOutlet weak var addTextField: UITextField!
    @IBAction func doneAction(_ sender: UIButton) {
        guard let text = addTextField.text else {return}
        if text.isEmpty {
            navigationController?.popViewController(animated: true)
            return
        } else {
           onNewItemAdded!(text)
           navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Return keyboard touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addTextField.resignFirstResponder()
    }
    
    // MARK: Return keyboard return-key (before have to do: add delegat from textField to controller and add protocol UITextFieldDelegate)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
}
