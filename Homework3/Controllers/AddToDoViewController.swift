//
//  AddToDoViewController.swift
//  Homework3
//
//  Created by detaysoft on 22.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var toDoListTableViewVC : ToDoListTableViewController = ToDoListTableViewController()
    
    @IBOutlet weak var importantSwitch: UISwitch!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonDidTap(_ sender: Any) {
        let toDo = ToDoModel()
        
        // It's bad practice to force unwrap an optional - e.g.
        // titleTextField.text!
        // This may be nil - as part of the tutorial on optionals,
        // this was corrected using if let - which basically
        // says that if the text field is not nil, proceed.
        // I added the alert.
        if let name = titleTextField.text {
            if name.isEmpty {
                // Show an alert
                let message = "Please enter a title to complete the ToDo."
                showAlert(message: message)
                return
            }
            else {
                toDo.name = name
            }
        }
        toDo.isImportant = importantSwitch.isOn
        // In my version, automatically return back to the main view if
        // saving is successful.
        if true == toDoListTableViewVC.addNewToDo(toDo: toDo) {
            // Return to the prior view controller.
            navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "ToDo Title Missing", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}


