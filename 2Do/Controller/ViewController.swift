//
//  ViewController.swift
//  2Do
//
//  Created by Nick on 06/07/2019.
//  Copyright © 2019 Nikita Gulak. All rights reserved.
//

import UIKit
import CoreData

var mainVC: ViewController?

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC = self
        fetchTasks()
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        tableView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9764705882, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTasks()
    }
    
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public Properties
    
    var myTasks: [ToDoTask] = []
    
    
    // MARK: - IBActions
    
    @IBAction func addNewTask(_ sender: UIButton) {
//        let newTaskVC = storyboard!.instantiateViewController(withIdentifier: "newTaskVC") as! NewTaskController
//        navigationController?.pushViewController(newTaskVC, animated: true)
    }
    
    
    //MARK: TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell
        cell.label.text = myTasks[indexPath.row].text
        cell.checkBox.tag = indexPath.row
        return cell
    }
    
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - CoreData Fetching
    
    func fetchTasks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.returnsObjectsAsFaults = false
        var fetchedTasks = [ToDoTask]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                fetchedTasks.append(ToDoTask(text: data.value(forKey: "text") as! String, isCompleted: data.value(forKey: "isCompleted") as! Bool))
            }
            myTasks = fetchedTasks
            tableView.reloadData()
        } catch {
            print("Failed fetching CoreData")
        }
    }
    
    
    // MARK: - CoreData Removing
    
    func deleteTask(tag: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let objectToDelete = result[tag] as! NSManagedObject
            context.delete(objectToDelete)
            do {
                try context.save()
                fetchTasks()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}
