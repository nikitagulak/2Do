//
//  TaskCell.swift
//  2Do
//
//  Created by Nick on 06/07/2019.
//  Copyright © 2019 Nikita Gulak. All rights reserved.
//

import UIKit

var foo = 2

class TaskCell: UITableViewCell {

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBox.layer.borderWidth = 1
        checkBox.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        checkBox.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var checkBox: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    
    // MARK: - IBActions
    
    @IBAction func checkBoxPressed(_ sender: UIButton) {
        mainVC?.deleteTask(tag: sender.tag)
    }
    
}
