//
//  NewTaskController.swift
//  2Do
//
//  Created by Nick on 06/07/2019.
//  Copyright © 2019 Nikita Gulak. All rights reserved.
//

import UIKit
import CoreData

class NewTaskController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - IBActions
    
    @IBAction func enterPressed(_ sender: UITextField) {
        if textField.text != "" {
            saveNewData()
        }
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - CoreData Saving
    
    func saveNewData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let newResult = NSManagedObject(entity: entity!, insertInto: context)
        newResult.setValue(textField.text!, forKey: "text")
        newResult.setValue(false, forKey: "isCompleted")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
