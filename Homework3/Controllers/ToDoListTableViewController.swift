//
//  ToDoListTableViewController.swift
//  Homework3
//
//  Created by detaysoft on 21.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var toDos : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func createToDos() -> [ToDoModel] {
        
        let eggs: ToDoModel = ToDoModel()
        eggs.name = "Buy eggs"
        eggs.isImportant = true
        
        let walkTheDog : ToDoModel = ToDoModel()
        walkTheDog.name = "Walk the dog"
        walkTheDog.isImportant = false
        
        let eatCheese: ToDoModel = ToDoModel()
        eatCheese.name = "Eat cheese"
        eatCheese.isImportant = false
        
        return [eggs, walkTheDog, eatCheese]
    }

    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let todo = toDos[indexPath.row]
        // Since we're using Core Data, todo.name is now an
        // optional.
        if var name = todo.name {
            
            if (todo.isImportant) {
                name = "❗️" + name
            }
            cell.textLabel?.text = name
        }
        return cell
    }
}
