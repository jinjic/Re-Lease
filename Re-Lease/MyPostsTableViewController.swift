//
//  MyPostsTableViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class MyPostsTableViewController: UITableViewController, CreatePostDelegate {
    
    var post: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        let createPostItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("presentCreatePostController"))
        self.navigationItem.setRightBarButtonItems([createPostItem], animated: false)
    }
    
    func createPostDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createPostDidSave() {
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.tableView.backgroundView = nil
        if self.post == nil {
            let noPostsView = NSBundle.mainBundle().loadNibNamed("MyPostsNoPostsView", owner: self, options: nil)[0] as UIView
            self.tableView.backgroundView = noPostsView
            self.tableView.separatorStyle = .None
            return 0;
        }
        
        self.tableView.separatorStyle = .SingleLine
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    @IBAction func presentCreatePostController() {
        let createPostController = CreatePostTableViewController()
        createPostController.delegate = self
        let createNavController = UINavigationController(rootViewController: createPostController)
        self.presentViewController(createNavController, animated: true, completion: nil)
    }
}
