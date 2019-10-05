//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Jarvis Rojas on 10/5/19.
//  Copyright © 2019 Jarvis Rojas. All rights reserved.
//

import UIKit
//PART EIGHT: CREATE A CUSTOM UITableViewCell
//Create a Cell Subclass

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}
class ToDoCell: UITableViewCell {
    
    var delegate: ToDoCellDelegate?

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    
   
    

}
