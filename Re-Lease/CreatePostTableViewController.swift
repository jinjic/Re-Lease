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
    
    var descriptionCell = UITableViewCell()
    var rentCell = UITableViewCell()
    var utilitiesCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
    var locationCell = UITableViewCell(style: .Default, reuseIdentifier: "DefaultLocationCell")
    var startDateCell = UITableViewCell(style: .Value1, reuseIdentifier: "DateCell")
    var endDateCell = UITableViewCell(style: .Value1, reuseIdentifier: "DateCell")
    
    var descriptionTextField: UITextField = UITextField()
    var rentTextField: UITextField = UITextField()
    
    var datePickerIndexPath: NSIndexPath?
    
    lazy var dateFormatter: NSDateFormatter = {
        var df = NSDateFormatter()
        df.dateFormat = "MMM dd"
        return df
    }()
    
    override func loadView() {
        super.loadView()
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        
        // description cell
        self.descriptionTextField = UITextField(frame: CGRectInset(self.descriptionCell.contentView.bounds, 15, 0))
        self.descriptionTextField.placeholder = "Describe Your Home"
        self.descriptionCell.addSubview(self.descriptionTextField)
        
        // rent cell
        self.rentTextField = UITextField(frame: CGRectInset(self.rentCell.contentView.bounds, 15, 0))
        self.rentTextField.placeholder = "How much do you pay?"
        self.rentCell.addSubview(self.rentTextField)
        
        // utilities cell
        self.utilitiesCell.textLabel?.text = "Utilities"
        self.utilitiesCell.detailTextLabel?.text = "None"
        self.utilitiesCell.accessoryType = .DisclosureIndicator
        
        // date cells
        self.startDateCell.textLabel?.text = "Lease Start"
        self.startDateCell.detailTextLabel?.text = self.dateFormatter.stringFromDate(NSDate())
        
        self.endDateCell.textLabel?.text = "Lease End"
        self.endDateCell.detailTextLabel?.text = self.dateFormatter.stringFromDate(NSDate())
        
        // location cell
        self.locationCell.textLabel?.text = "Find Location"
        self.locationCell.textLabel?.textColor = UIColor.lightGrayColor()
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
        return 3
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 3
        case 1:
            if self.datePickerIndexPath == nil {
                return 2
            } else {
                return 3
            }
        case 2:
            return 1
            
        default:
            return 0
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return self.descriptionCell
            case 1:
                return self.rentCell
            case 2:
                return self.utilitiesCell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return self.startDateCell
            case 1:
                if self.datePickerIndexPath == nil {
                    return self.endDateCell
                } else {
                    let datePickerCell = NSBundle.mainBundle().loadNibNamed("DatePickerCell", owner: self, options: nil)[0] as UITableViewCell
                    return datePickerCell
                }
            case 2:
                if indexPath == self.datePickerIndexPath {
                    let datePickerCell = NSBundle.mainBundle().loadNibNamed("DatePickerCell", owner: self, options: nil)[0] as UITableViewCell
                    return datePickerCell
                } else {
                    return self.endDateCell
                }
            default:
                fatalError("unexpected index")
            }
        case 2:
            switch indexPath.row {
            case 0:
                return self.locationCell
            default:
                return UITableViewCell()
            }
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.reuseIdentifier == "DateCell" {
            tableView.beginUpdates()
            
            var before: Bool = false
            var sameCellClicked: Bool = false
            if let datePickerIndexPath = self.datePickerIndexPath {
                let oldCell: UITableViewCell? = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: datePickerIndexPath.row - 1, inSection: 1))
                oldCell?.detailTextLabel?.textColor = UIColor.blackColor()
                before = datePickerIndexPath.row < indexPath.row
                sameCellClicked = datePickerIndexPath.row - 1 == indexPath.row
                tableView.deleteRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
                self.datePickerIndexPath = nil
            }
            
            if !sameCellClicked {
                // the index path to insert the date picker
                cell?.detailTextLabel?.textColor = UIColor(red: 32/255, green: 69/255, blue: 125/255, alpha: 1)
                var newRow: Int = before ? indexPath.row : indexPath.row + 1
                var newIndexPath: NSIndexPath = NSIndexPath(forRow: newRow, inSection: 1)
                self.datePickerIndexPath = newIndexPath
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
            tableView.endUpdates()
        } else if cell?.reuseIdentifier == "DefaultLocationCell" || cell?.reuseIdentifier == "PostLocationCell" {
//            self.performSegueWithIdentifier("LocationSearchSegue", sender: self)
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
    
    // MARK: - DatePicker Delegate
    
    @IBAction func dateChanged(sender: AnyObject) {
        self.tableView.endEditing(true)
        let datePicker: UIDatePicker = sender as UIDatePicker
        if let datePickerIndexPath = self.datePickerIndexPath {
            let targetedCellIndexPath: NSIndexPath = NSIndexPath(forRow: datePickerIndexPath.row - 1, inSection: datePickerIndexPath.section)
            let cell: UITableViewCell? = self.tableView.cellForRowAtIndexPath(targetedCellIndexPath)
            cell?.detailTextLabel?.text = self.dateFormatter.stringFromDate(datePicker.date)
            if self.datePickerIndexPath?.row == 1 {
                self.newPost.startDate = datePicker.date
            } else {
                self.newPost.endDate = datePicker.date
            }
        }
    }
    
    // MARK: - Scroll View Methods
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.tableView.endEditing(true)
    }
}
