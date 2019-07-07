//
//  EditTaskController.swift
//  2Do
//
//  Created by Nick on 07/07/2019.
//  Copyright © 2019 Nikita Gulak. All rights reserved.
//

import UIKit
import CoreData

var selectedCellNumber: Int?

class EditTaskController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        if let index = selectedCellNumber {
            textField.text = mainVC?.myTasks[index].text
        } else {
            print("Failed passing cell tag")
        }
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        updateTask()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enterPressed(_ sender: UITextField) {
        updateTask()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - CoreDate Update
    
    func updateTask() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if let index = selectedCellNumber {
                let objectToUpdate = result[index] as! NSManagedObject
                objectToUpdate.setValue(textField.text, forKey: "text")
                do {
                    try context.save()
                    mainVC?.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        } catch {
            print("Failed updating CoreData")
        }
    }
    
}
