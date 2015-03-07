//
//  LogInViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet var usernameTextField: BorderUITextField!
    @IBOutlet var passwordTextField: BorderUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: self.usernameTextField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: self.passwordTextField.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        let tapGesture = UITapGestureRecognizer(target: self, action:Selector("dismissKeyboard:"))
    }
    
    func dismissKeyboard(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func didTapLogInButton(sender: AnyObject) {
        var username = self.usernameTextField.text
        var password = self.passwordTextField.text
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser!, error: NSError!) -> Void in
            if error == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}
