//
//  ToDoListTableViewController.swift
//  Homework3
//
//  Created by detaysoft on 21.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import UIKit
import CoreData

class ToDoListTableViewController: UITableViewController {
    
    @IBOutlet weak var checkedImage: UIImageView!
    var toDos : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToDos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToDos()
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
            cell.imageView?.image = UIImage(named: todo.isChecked == true ? "checked" : "unchecked")
        }
        return cell
    }
    // Get the ToDos from CoreData
    func getToDos() {
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            do {
                let request:NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
                let coreDataToDos = try context.fetch(request) as? [ToDoItem]
                if let coreDataToDos = coreDataToDos {
                    // We can just set our ToDoItem array to the one given
                    // to us by Core Data - note that toDos is now [ToDoItem]
                    self.toDos = coreDataToDos
                }
                tableView.reloadData()
            }
            catch {
                showAlert(message: "Could not retrieve the ToDo items from the database! Please try again.")
                return
            }
        }
    }
    // In the tutorial, the code was handled by the add ToDo VC,
    // which isn't the best.  I added the function handler instead.
    func addNewToDo(toDo: ToDoModel) -> Bool {
        var success : Bool = true
        // Get the managed object context
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            let toDoItem = ToDoItem(entity: ToDoItem.entity(), insertInto: context)
            toDoItem.name = toDo.name
            toDoItem.isImportant = toDo.isImportant
            toDoItem.createdDate = Date()
            // This can also be handled this way:
            // try? context.save
            // But then there's no handling the failure case...
            // To get the data to "reload" we need to handle
            // viewWillAppear.
            do {
                try context.save()
            }
            catch {
                self.showAlert(message: "Data could not be saved!  Please try again.")
                success = false
            }
        }
        return success
    }
    // Added the function instead of code directly in other view
    func completeToDo(toDo toDoItem: ToDoItem) {
        // Using Core Data, all we need to do is remove the item
        // from Core Data.
        
        toDoItem.isChecked = toDoItem.isChecked == true ? false : true;
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            do {
                try context.save()
            }
            catch {
                self.showAlert(message: "Data could not be saved!  Please try again.")
            }
            // Update the tableView
            getToDos()
        }
    }
    
    func deleteToDoItem(toDo toDoItem: ToDoItem) {
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            do {
              try   context.delete(toDoItem)
            }
            catch {
                self.showAlert(message: "Data could not be saved!  Please try again.")
            }
           // getToDos()
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Navigation

    // We will use this prepare to give the add ToDo VC a reference to this
    // View Controller.  Using if let to make sure the destination IS a add VC.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.toDoListTableViewVC = self
        }
        else if let completeVC = segue.destination as? CompleteToDoViewController {
            completeVC.toDoListTableViewVC = self
            if let toDo = sender as? ToDoItem {
                completeVC.selectedToDo = toDo
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "completeToDoSegue", sender: toDo)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDoLine = toDos[indexPath.section]
            deleteToDoItem(toDo: toDoLine)
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

    

