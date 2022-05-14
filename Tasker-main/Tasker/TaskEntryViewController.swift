//
//  TaskEntryViewController.swift
//  Tasker
//
//  Created by Rohan Rawat on 3/12/22.

import UIKit

class TaskEntryViewController: UIViewController {
    
    private var newTask: TaskEntry?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDetailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Setters and getters
    func getNewTask() -> TaskEntry?{
        return newTask
    }
    
    func setNewTask(t:TaskEntry) {
        newTask = t
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let newTask = newTask {
            taskNameTextField.text = newTask.task
            taskDetailsTextView.text = newTask.summary
        }
        else {
            taskNameTextField.text = ""
            taskDetailsTextView.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identity = segue.identifier
        else
        {
            return
            
        }
        
        if (identity == "Save New Task") {
            let newTask = Database.createTask()
            newTask.task = taskNameTextField.text ?? ""
            newTask.summary = taskDetailsTextView.text ?? ""
            newTask.entryDate = Date()
            print("Saved new Task!")
            Database.save()
        }
        else if (identity == "Undo Action") {
            print("Pressed Cancel!")
        }
        else{
            print("Error segue!")
        }

    }
}
