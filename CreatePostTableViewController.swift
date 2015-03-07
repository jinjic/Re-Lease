//
//  CreatePostTableViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

protocol CreatePostDelegate: class {
    func createPostDidCancel()
    func createPostDidSave()
}

class CreatePostTableViewController: UITableViewController {
    
    weak var delegate: CreatePostDelegate!
    
    var nameCell: UITableViewCell = UITableViewCell()
    var utilitiesCell: UITableViewCell = UITableViewCell()
    var locationCell: UITableViewCell = UITableViewCell()
    
    var nameTextField: UITextField = UITextField()
    var utilitiesTextField: UITextField = UITextField()
    
    override func loadView() {
        super.loadView()
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        // construct first name cell, section 0, row 0
        self.nameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.nameTextField = UITextField(frame: CGRectInset(self.nameCell.contentView.bounds, 15, 0))
        self.nameTextField.placeholder = "Name"
        self.nameCell.addSubview(self.nameTextField)
        
        // construct last name cell, section 0, row 1
        self.utilitiesCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.utilitiesTextField = UITextField(frame: CGRectInset(self.utilitiesCell.contentView.bounds, 15, 0))
        self.utilitiesTextField.placeholder = "Utilities?"
        self.utilitiesCell.addSubview(self.utilitiesTextField)
        
        // construct share cell, section 1, row 0
        self.locationCell.textLabel?.text = "Find Location"
        self.locationCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("didTapCancelButton"))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("didTapDoneButton"))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func didTapCancelButton() {
        self.delegate.createPostDidCancel()
    }
    
    func didTapDoneButton() {
        self.delegate.createPostDidSave()
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
