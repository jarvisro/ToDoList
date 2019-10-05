//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Jarvis Rojas on 10/2/19.
//  Copyright © 2019 Jarvis Rojas. All rights reserved.
//

import UIKit
  //PART FIVE: CONNECT THE STATIC TABLE VIEW TO CODE PAGE 746
//Add A View Controller Subclass pg 746
class ToDoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Update Date Label pg. 750
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
        //Update the Date Picker Starting Value Pgabe 751
        dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        
        //Update the Static TAble View Controller PAGE: 759
        // when a to do is selected the to do view controller will pre load the view with the data of the to do that you want to edit
        if let todo = todo {
            navigationItem.title = "Edit To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
    }
    
  
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextField!
    
    //Disable the save button pg 747
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    //Dismiss Keyboard on Return pg 748
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    //Switch Button Image pg 749
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    //Update date Label pg. 750
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    //Update Date Label pg. 751
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
   
    //Expand and Collapse the Date Picker Cell pg. 752
    var isEndDatePickerHidden = true
    // MARK: - Table view data source
//Expand and Collapse the DAte Picker Cell pg 753
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [1,0]: // Due Date Cell
            return isEndDatePickerHidden ? normalCellHeight : largeCellHeight
            
        case [2,0]: //Notes Cell
            return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            tableView.cellForRow(at: indexPath)?.isSelected = false
        isEndDatePickerHidden = !isEndDatePickerHidden
        dueDateLabel.textColor = isEndDatePickerHidden ? .black : tableView.tintColor
            
        tableView.beginUpdates()
        tableView.endUpdates()
        default: break
        }
    }
        
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    //PART SIX: CREATE AND SAVE THE MODEL PAGE 754
    //page 756
    
    var todo: ToDo?
    
    
    
    //Read Data from Controls pg 755: Read the values from the appropriate controls, store them into canstants, and pass the values into model's initializer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind"  else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
   
    todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    

}
