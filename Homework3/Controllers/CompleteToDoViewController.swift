//
//  CompleteToDoViewController.swift
//  Homework3
//
//  Created by detaysoft on 22.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import UIKit

class CompleteToDoViewController: UIViewController {
    var toDoListTableViewVC : ToDoListTableViewController = ToDoListTableViewController()
    var selectedToDo: ToDoItem?
    
    @IBOutlet weak var completeToDoButton: UIButton!
    @IBOutlet weak var completeToDoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // You can also set this (without the ! code as
        // completeToDoLabel.text = selectedToDo?.name
        // Ths says if the selectedToDo isn't nil, use it,
        // otherwise, set the name as nil...
        
        if let selectedToDo = self.selectedToDo {
            
            if var name = selectedToDo.name {
                if (selectedToDo.isImportant) {
                    name = "❗️" + name
                }

                completeToDoLabel.text = name
            }
        }
        
        if(selectedToDo?.isChecked == true) {
            completeToDoButton.setTitle("Unchecked", for: .normal)
        } else {
            completeToDoButton.setTitle("Checked", for: .normal)
        }
    }
    
    @IBAction func completeButtonDidTap(_ sender: Any) {
        if let completedToDo = selectedToDo {
            toDoListTableViewVC.completeToDo(toDo: completedToDo)
        }
        navigationController?.popViewController(animated: true)
    }
}
