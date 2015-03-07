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
    func createPostDidSaveWithPost(post: Post)
}

class CreatePostTableViewController: UITableViewController {
    
    weak var delegate: CreatePostDelegate!
    var newPost = Post.object()
    
    var descriptionCell: UITableViewCell = UITableViewCell()
    var rentCell: UITableViewCell = UITableViewCell()
    var utilitiesCell: UITableViewCell = UITableViewCell()
    var locationCell: UITableViewCell = UITableViewCell()
    
    var descriptionTextField: UITextField = UITextField()
    var rentTextField: UITextField = UITextField()
    
    override func loadView() {
        super.loadView()
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        // description cell
        self.descriptionCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.descriptionTextField = UITextField(frame: CGRectInset(self.descriptionCell.contentView.bounds, 15, 0))
        self.descriptionTextField.placeholder = "Describe Your Home"
        self.descriptionCell.addSubview(self.descriptionTextField)
        
        // rent cell
        self.rentCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.rentTextField = UITextField(frame: CGRectInset(self.rentCell.contentView.bounds, 15, 0))
        self.rentTextField.placeholder = "How much do you pay?"
        self.rentCell.addSubview(self.rentTextField)
        
        // utilities cell
        self.utilitiesCell.textLabel?.text = "Find Location"
        self.utilitiesCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
        // location cell
        self.locationCell.textLabel?.text = "Find Location"
        self.locationCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Create"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("didTapCancelButton"))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("didTapDoneButton"))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func didTapCancelButton() {
        self.delegate.createPostDidCancel()
    }
    
    func didTapDoneButton() {
        
    }
    
    func savePost() {
        self.delegate.createPostDidSaveWithPost(self.newPost)
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
                return self.descriptionCell
            case 1:
                return self.rentCell
            case 2:
                return self.utilitiesCell
            case 3:
                return self.locationCell
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "What"
        case 1:
            return "When"
        case 2:
            return "Where"
        default:
            fatalError("Unexpected index for title")
        }
    }
}
