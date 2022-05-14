//
//  TasksViewController.swift
//  Tasker
//
//  Created by Rohan Rawat on 3/12/22.

import UIKit

class TasksViewController: UITableViewController {
    
    // Store all our tasks
    private var entries = [TaskEntry]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        entries = Database.getTasks()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! TableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let currentTask = entries[indexPath.row]
        if let unwrapTask = currentTask.task {
            cell.taskNameLabel.text = "Task: " + unwrapTask
        } else {
            print("Error unwrapping task optional!")
            cell.taskNameLabel.text = "Error!"
        }
        
        if let unwrapDate = currentTask.entryDate {
            let modifiedDate = dateFormatter.string(from: unwrapDate)
            cell.dateLabel.text = "Date: " + modifiedDate
            
        } else {
            print("Error unwrapping task optional!")
            cell.taskNameLabel.text = "Error!"
        }
        

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identity = segue.identifier else { return }
        
        if (identity == "ShowTasks") {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = entries[indexPath.row]
            let destination = segue.destination as! TaskEntryViewController
            destination.setNewTask(t:note)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Database.deleteTask(task: entries[indexPath.row])
            entries = Database.getTasks()
        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        entries = Database.getTasks()
    }

}
