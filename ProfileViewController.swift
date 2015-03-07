//
//  ProfileViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicture.layer.borderWidth = 1
        profilePicture.clipsToBounds = true
        profilePicture.layer.cornerRadius = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
