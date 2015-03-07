//
//  notificationsViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class NotificationsViewController: UITableViewController {
    
    
    let cellIdentifier = "cell"
    let items: [String] = ["Tommy Groomes", "Steven Covey", "Ashley Jackson"]
    var subtitles: [String] = ["Today", "Yesterday", "3 days ago"]
    
    let profileMessage: [String] = ["Tommy Gromes", "Steven Covey"]
    let txtMessages: [String] = ["Hey Dan, can I take a tour on Tuesday?", "I'll be in town Friday, could I checkout out the place?"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let array: [String] = ["Views", "Messages"]
        let control = UISegmentedControl(items: array)
        control.sizeToFit()
        control.selectedSegmentIndex = 0
        
        control.addTarget(self, action: Selector("controlSwitch"), forControlEvents: UIControlEvents.ValueChanged)
        
        return control
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.titleView = UISegmentedControl()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.titleView = segmentedControl
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
            
        }
        
        if(segmentedControl.selectedSegmentIndex == 0) {
            cell?.imageView?.image = UIImage(named: "Profile\(indexPath.row)")
            cell?.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
            cell?.imageView?.layer.borderWidth = 1
            cell?.imageView?.clipsToBounds = true
            cell?.imageView?.layer.cornerRadius = 33
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.text = self.items[indexPath.row]
            cell?.detailTextLabel?.text = self.subtitles[indexPath.row]
        }
        else {
            cell?.imageView?.image = UIImage(named: "Profile\(indexPath.row)")
            cell?.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
            cell?.imageView?.layer.borderWidth = 1
            cell?.imageView?.clipsToBounds = true
            cell?.imageView?.layer.cornerRadius = 33
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.text = self.profileMessage[indexPath.row]
            cell?.detailTextLabel?.text = self.txtMessages[indexPath.row]
        }
        
        
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(segmentedControl.selectedSegmentIndex == 0) {
            return self.items.count
        }
        else {
            return self.profileMessage.count
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    func controlSwitch() {
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
