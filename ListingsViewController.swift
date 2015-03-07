//
//  ListingsViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class ListingsViewController: PFQueryTableViewController {
    
    var cell = PFTableViewCell()
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parseClassName = "Post"
        navigationItem.title = "Rooms"
        self.loadObjects()
        
    }
    
    override func queryForTable() -> PFQuery! {
        var query = Post.query()
        
        return query
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        let post = object as Post

        cell?.imageView?.image = UIImage(named: "josipsucks\(indexPath.row )")
        
        if(cell == nil) {
            cell = PFTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = post.name
        cell?.detailTextLabel?.text = post.rent

     
        
        return cell
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
