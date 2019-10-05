//
//  ToDo.swift
//  ToDoList
//
//  Created by Jarvis Rojas on 10/2/19.
//  Copyright © 2019 Jarvis Rojas. All rights reserved.
//

import Foundation

//PART TWO: SET UP PROJECT AND DISPLAY MODELS Page 729
//Define the Model Page 731
struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    //Update Date Lable PAge 750
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    //Supply Initial Data
       static func loadToDos() -> [ToDo]? {
           //Logic to load data from disk page. 768
        guard let codedTodos = try? Data(contentsOf: ArchiveURL) else {return nil}
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedTodos)
        
       }
    //Supply Initial Data
    static func loadSampleTodos() -> [ToDo] {
        let todo1 = ToDo(title: "Todo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "Todo two", isComplete: false, dueDate: Date(), notes: "Note 2")
        let todo3 = ToDo(title: "Todo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
    //PART NINE: CODABLE PAge 767
    //Add Support for Archiving and Unarchiving
    //defined path for the stored data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    //Before we can read model data from the disk we have to create a way to save it to disk.
    static func SaveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
