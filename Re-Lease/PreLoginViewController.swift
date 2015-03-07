//
//  PreLoginViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class PreLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLogInButton(sender: AnyObject) {
        let login = LogInViewController(nibName: "LogInViewController", bundle: nil)
        self.navigationController?.pushViewController(login, animated: true)
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
