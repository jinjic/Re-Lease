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
    
    var userChats: [UserChat]!
    
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
        self.navigationItem.titleView = UISegmentedControl()
        self.navigationItem.titleView = segmentedControl
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: Selector("queryForTable"))
        self.queryForTable()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell?.imageView?.image = UIImage(named: "Profile\(indexPath.row)")
            cell?.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
            cell?.imageView?.layer.borderWidth = 1
            cell?.imageView?.clipsToBounds = true
            cell?.imageView?.layer.cornerRadius = 33
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.text = self.items[indexPath.row]
            cell?.detailTextLabel?.text = self.subtitles[indexPath.row]
        } else {
            var userchat = self.userChats[indexPath.row]
            cell?.imageView?.image = UIImage(named: "Profile\(indexPath.row)")
            cell?.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
            cell?.imageView?.layer.borderWidth = 1
            cell?.imageView?.clipsToBounds = true
            cell?.textLabel?.numberOfLines = 1
            cell?.imageView?.layer.cornerRadius = 33
            cell?.textLabel?.text = userchat.lastMessage
            cell?.detailTextLabel?.text = userchat.desc
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0) {
            return self.items.count
        }
        else {
            if self.userChats == nil {
                return 0
            } else {
                return self.userChats.count
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if self.segmentedControl.selectedSegmentIndex == 1 {
            let messagesDetail = MessagesDetailTableViewController()
            messagesDetail.chatRoomId = self.userChats[indexPath.row].roomId
            messagesDetail.hidesBottomBarWhenPushed = true
            messagesDetail.userChat = self.userChats[indexPath.row]
            self.navigationController?.pushViewController(messagesDetail, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    func controlSwitch() {
        self.tableView.reloadData()
    }
    
    // MARK: - Query
    
    func queryForTable() {
        if PFUser.currentUser() == nil {
            return
        }
        var query = UserChat.query()
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.includeKey("user")
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.userChats = objects as [UserChat]
                self.tableView.reloadData()
            }
        }
    }
}
