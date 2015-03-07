//
//  notificationsViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class NotificationsViewController: UITableViewController {
    
    
    var constraints: [NSLayoutConstraint] = []
    
    var items: [String] = ["Lisa Anne", "Steven Covey", "Ashley Jackson"]

    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Notifications"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
