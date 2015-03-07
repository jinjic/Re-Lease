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

class CreatePostTableViewController: UITableViewController, CreatePostLocationSearchDelegate {
    
    weak var delegate: CreatePostDelegate!
    var newPost = Post.object()
    
    var descriptionCell = UITableViewCell()
    var rentCell = UITableViewCell()
    var utilitiesCell: UITableViewCell!
    var locationCell = UITableViewCell(style: .Default, reuseIdentifier: "DefaultLocationCell")
    var postLocationCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "PostLocationCell")
    var startDateCell = UITableViewCell(style: .Value1, reuseIdentifier: "DateCell")
    var endDateCell = UITableViewCell(style: .Value1, reuseIdentifier: "DateCell")
    
    var descriptionTextField: UITextField = UITextField()
    var rentTextField: UITextField = UITextField()
    
    var datePickerIndexPath: NSIndexPath?
    
    lazy var dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateFormat = "MMMM d, YYYY"
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
        self.utilitiesCell = NSBundle.mainBundle().loadNibNamed("UtilitiesCell", owner: self, options: nil)[0] as UITableViewCell
        
        // date cells
        self.startDateCell.textLabel?.text = "Start"
        self.startDateCell.detailTextLabel?.text = self.dateFormatter.stringFromDate(NSDate())
        
        self.endDateCell.textLabel?.text = "End"
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
        
        self.electricButton.addTarget(self, action: Selector("didTapButton:"), forControlEvents: .TouchUpInside)
        self.waterButton.addTarget(self, action: Selector("didTapButton:"), forControlEvents: .TouchUpInside)
        self.gasButton.addTarget(self, action: Selector("didTapButton:"), forControlEvents: .TouchUpInside)
    }
    
    func didTapCancelButton() {
        self.delegate.createPostDidCancel()
    }
    
    func didTapDoneButton() {
        self.newPost.description = self.descriptionTextField.text
        self.newPost.rent = self.rentTextField.text
        var utilitiesArray: [String] = []
        if self.electricButton.selected {
            utilitiesArray.append("Electric")
        }
        if self.waterButton.selected {
            utilitiesArray.append("Water")
        }
        if self.gasButton.selected {
            utilitiesArray.append("Gas")
        }
        self.newPost.utilities = utilitiesArray
        self.newPost.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if error == nil {
                self.delegate.createPostDidSaveWithPost(self.newPost)
            }
        }
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
                if self.newPost.location == nil {
                    return self.locationCell
                } else {
                    self.postLocationCell.textLabel?.text = self.newPost.location.name
                    self.postLocationCell.detailTextLabel?.text = self.newPost.location.address
                    return self.postLocationCell
                }
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
                cell?.detailTextLabel?.textColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
                var newRow: Int = before ? indexPath.row : indexPath.row + 1
                var newIndexPath: NSIndexPath = NSIndexPath(forRow: newRow, inSection: 1)
                self.datePickerIndexPath = newIndexPath
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
            tableView.endUpdates()
        } else if cell?.reuseIdentifier == "DefaultLocationCell" || cell?.reuseIdentifier == "PostLocationCell" {
            let locationSearchController = CreatePostLocationSearchTableViewController()
            locationSearchController.searchDelegate = self
            let navController = UINavigationController(rootViewController: locationSearchController)
            self.presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == self.datePickerIndexPath {
            return 216
        } else if indexPath.section == 0 && indexPath.row == 2 {
            return 115
        }
        
        return tableView.rowHeight
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "What"
        case 1:
            return "Availability"
        case 2:
            return "Where"
        default:
            fatalError("Unexpected index for title")
        }
    }
    
    // MARK: - Location Search Delegate
    
    func locationSearchDidSelectPostLocation(postLocation: PostLocation) {
        self.newPost.location = postLocation
        self.tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: .Automatic)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func locationSearchDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    // MARK: - IBAction for Buttons
    
    @IBOutlet var electricButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var gasButton: UIButton!
    
    func didTapButton(sender: UIButton) {
        sender.selected = sender.selected ? false : true
        if sender.selected {
            sender.alpha = 1
        } else {
            sender.alpha = 0.3
        }
    }
    
    // MARK: - Scroll View Methods
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.tableView.endEditing(true)
    }
}
