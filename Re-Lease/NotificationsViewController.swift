//
//  notificationsViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class NotificationsViewController: UITableViewController {
    
    
    var segmentControl = UISegmentedControl()
    let cellIdentifier = "cell"
    let items: [String] = ["Tommy Groomes", "Steven Covey", "Ashley Jackson"]
    var subtitles: [String] = ["Today", "Yesterday", "3 days ago"]

    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Notifications"
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
            
        }
        
        cell?.imageView?.image = UIImage(named: "Profile\(indexPath.row)")
        cell?.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
        cell?.imageView?.layer.borderWidth = 1
        cell?.imageView?.clipsToBounds = true
        cell?.imageView?.layer.cornerRadius = 33
        
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text = self.items[indexPath.row]
        
        
        cell?.detailTextLabel?.text = self.subtitles[indexPath.row]
        
        
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
