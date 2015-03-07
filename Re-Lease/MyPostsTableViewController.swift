//
//  MyPostsTableViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class MyPostsTableViewController: UITableViewController, CreatePostDelegate {
    
    var createPostBarButtonItem: UIBarButtonItem!
    var signInBarButtonItem: UIBarButtonItem!
    
    var posts: [Post]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.createPostBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("presentCreatePostController"))
        self.signInBarButtonItem = UIBarButtonItem(title: "Sign In", style: .Bordered, target: self, action: Selector("presentSignInController"))
        if PFUser.currentUser() == nil {
            self.navigationItem.rightBarButtonItem = self.signInBarButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = self.createPostBarButtonItem
        }
    }
    
    func createPostDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createPostDidSaveWithPost(post: Post) {
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.tableView.backgroundView = nil
        if self.posts == nil || self.posts?.count == 0  {
            let noPostsView = NSBundle.mainBundle().loadNibNamed("MyPostsNoPostsView", owner: self, options: nil)[0] as UIView
            self.tableView.backgroundView = noPostsView
            self.tableView.separatorStyle = .None
            return 0;
        }
        
        self.tableView.separatorStyle = .SingleLine
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    @IBAction func presentCreatePostController() {
        let createPostController = CreatePostTableViewController()
        createPostController.delegate = self
        let createNavController = UINavigationController(rootViewController: createPostController)
        self.presentViewController(createNavController, animated: true, completion: nil)
    }
    
    func presentSignInController() {
        
    }
}
