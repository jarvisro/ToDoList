//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Jarvis Rojas on 10/2/19.
//  Copyright © 2019 Jarvis Rojas. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController,
// Add a Cell Delegate Method
ToDoCellDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleTodos()
        }
     // Deleting Items Page 740 Intelligent edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
//Configure the Table View Controller
    var todos = [ToDo]()
    
  //Add a Cell Delegate Method Page 764
    //Determin the path of the cell
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.SaveToDos(todos)
        }
        
    }
    
    
    // MARK: - Table view data source
//Configure the Table View Controller
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//Configure the Table View Controller
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todos.count
    }

    //Configure the Table View Controller
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could  not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        // PARTEIGHT: CREATE A CUSTOM CELL PAGE 762
        // designing the cell pg. 764
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        
//Add a Cell Delegate Method Page 764
        // Add a Cell Delegate Method
        cell.delegate = self
        return cell
    }
    

    
    // Deleting Items Page 738
//    Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

//Deleting Items Page 738 red Delete Button Appears
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.SaveToDos(todos)
        }
        
//        else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //Pass DAta Across the Unwind Segue Page 755
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! ToDoViewController
        
        if let todo = sourceViewController.todo {
            
            //Update the Unwind Segue Logic pg 60
                      //this code will replace a todo that has been edited as oppose to adding a new one at the end of the table and adding a new object in the arrey
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            
          
        } else {
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.SaveToDos(todos)
      }
     //PART SEVEN: EDITING DETAILS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
    
}
