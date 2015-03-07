//
//  GroupDetailMessagesTableViewController.swift
//  Studies
//
//  Created by Alois Barreras on 10/28/14.
//  Copyright (c) 2014 Alois Barreras. All rights reserved.
//

import UIKit

class MessagesDetailTableViewController: UITableViewController {
    
    private var isFirstTime = true
    private var limit = 20
    private var sendMessageTextField: UITextField!
    private var sendMessageButton: UIButton!
    // used in calculating cell height
    private var viewWidthProportion: CGFloat!
    var objects: [Message] = []
    var chatRoomId: String!
    var userChat: UserChat!
    
    override func loadView() {
        super.loadView()

        // set up the input accessory view and grab the text field and buttons and store them here
        let tableView = MessagesTableView(frame: UIScreen.mainScreen().bounds)
        let keyboardBar = KeyboardBar()
        self.sendMessageTextField = keyboardBar.textField
        self.sendMessageButton = keyboardBar.sendButton
        self.sendMessageButton.addTarget(self, action: Selector("didTapSendMessageButton"), forControlEvents: .TouchUpInside)
        tableView.inputAccessoryView = keyboardBar
        
        // set the tableview and set some styling
        self.tableView = tableView
        self.tableView.separatorStyle = .None
        self.tableView.keyboardDismissMode = .Interactive
        
        // register the nibs
        let messageNib = UINib(nibName: "MessageTableViewCell", bundle:nil)
        let incomingMessageNib = UINib(nibName: "IncomingMessageTableViewCell", bundle:nil)
        
        self.tableView.registerNib(messageNib, forCellReuseIdentifier: "MessageTableViewCell")
        self.tableView.registerNib(incomingMessageNib, forCellReuseIdentifier: "IncomingMessageTableViewCell")
        
        self.addTapGestureRecognizerForDismissKeyboard()
        self.tableView.becomeFirstResponder()
    }
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWidthProportion = self.view.bounds.width * 3 / 4
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("didRefresh"), forControlEvents: .ValueChanged)
        let title: String = "Loading messages..."
        var attrsDictionary = [NSForegroundColorAttributeName : UIColor.blackColor()]
        let attributedTitle: NSAttributedString = NSAttributedString(string: title, attributes: attrsDictionary)
        refreshControl.attributedTitle = attributedTitle

        self.refreshControl = refreshControl
        self.queryForTable()
        self.addTapGestureRecognizerForDismissKeyboard()
    }
    
    // MARK: - Helpers
    
    private func addTapGestureRecognizerForDismissKeyboard() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard"))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissKeyboard() {
        self.tableView.becomeFirstResponder()
    }
    
    func didTapSendMessageButton() {
        self.sendMessage()
    }
    
    private func sendMessage() {
        if !(countElements(self.sendMessageTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) > 0) {
            return
        }
        let newMessage = Message.object()
        newMessage.user = PFUser.currentUser()
        newMessage.body = self.sendMessageTextField.text
        newMessage.roomId = self.chatRoomId
        newMessage.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if error == nil {
                self.getRecentMessages()
                self.sendMessageTextField.text = nil
            }
        }
        self.userChat.lastMessage = self.sendMessageTextField.text
        self.userChat.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if error == nil {
                
            }
        }
    }
    
    // MARK: - Table View Methods
    
    private func queryForTable() {
        self.refreshControl?.beginRefreshing()
        var query = Message.query()
        query.orderByDescending("createdAt")
        query.whereKey("roomId", equalTo: self.chatRoomId)
        query.limit = self.limit
        query.skip = self.objects.count
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.refreshControl?.endRefreshing()
            if error == nil && objects.count > 0 {
                self.loadNewCellsWithMessages(objects.reverse() as [Message])
                if self.isFirstTime {
                    // scroll to bottom
                    self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.objects.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: false)
                    self.isFirstTime = false
                } else {
                    // scroll so the older messages are just peeking out from under the nav bar
                    self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: objects.count, inSection: 0), atScrollPosition: .Top, animated: false)
                    self.tableView.setContentOffset(CGPointMake(0, self.tableView.contentOffset.y - 35), animated: true)
                }
            }
        }
    }
    
    private func getRecentMessages() {
        var query = Message.query()
        query.limit = 1000
        query.orderByDescending("createdAt")
        query.whereKey("roomId", equalTo: self.chatRoomId)
        if let mostRecentMessage = self.objects.last {
            query.whereKey("createdAt", greaterThan: mostRecentMessage.createdAt)
        }
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                let newMessages = objects.reverse() as [Message]
                self.objects += newMessages
                self.tableView.reloadData()
                // scroll to bottom
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.objects.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
            }
        }
    }
    
    private func loadNewCellsWithMessages(messages: [Message]) {
        self.objects = messages + self.objects
        // TODO: find a way to do this without reloading the entire table
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = self.objects[indexPath.row]
        let fromUser = message.user
        if fromUser.objectId == PFUser.currentUser().objectId {
            var cell: MessageTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("MessageTableViewCell") as MessageTableViewCell
            cell.messageBodyLabel.text = message.body
            return cell
        } else {
            var cell: IncomingMessageTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("IncomingMessageTableViewCell") as IncomingMessageTableViewCell
            cell.messageBodyLabel.text = message.body
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let messageBody = self.objects[indexPath.row].body as NSString
        let constraintSize: CGSize = CGSizeMake(self.viewWidthProportion, CGFloat.max)
        let textSize: CGSize = messageBody.boundingRectWithSize(constraintSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: 17)!], context: nil).size
        
        return ceil(textSize.height) + 33
    }
    
    func didRefresh() {
        self.queryForTable()
    }
}