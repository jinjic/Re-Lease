//
//  CreatePostTableViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class CreatePostTableViewController: UITableViewController {
    
    var nameCell: UITableViewCell = UITableViewCell()
    var utilitiesCell: UITableViewCell = UITableViewCell()
    var locationCell: UITableViewCell = UITableViewCell()
    
    var nameTextField: UITextField = UITextField()
    var utilitiesTextField: UITextField = UITextField()
    
    override func loadView() {
        // set the title
        self.title = "User Options"
        
        // construct first name cell, section 0, row 0
        self.nameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.nameTextField = UITextField(frame: CGRectInset(self.nameCell.contentView.bounds, 15, 0))
        self.nameTextField.placeholder = "Name"
        self.nameTextField.addSubview(self.nameTextField)
        
        // construct last name cell, section 0, row 1
        self.utilitiesCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.utilitiesTextField = UITextField(frame: CGRectInset(self.utilitiesCell.contentView.bounds, 15, 0))
        self.utilitiesTextField.placeholder = "Utilities?"
        self.utilitiesTextField.addSubview(self.utilitiesTextField)
        
        // construct share cell, section 1, row 0
        self.locationCell.textLabel?.text = "Share with Friends"
        self.locationCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.locationCell.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 3   // section 0 has 2 rows
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                return self.nameCell
            case 1:
                return self.utilitiesCell
            case 2:
                return self.locationCell
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
    }
}
