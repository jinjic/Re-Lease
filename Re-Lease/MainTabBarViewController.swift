//
//  MainTabBarViewController.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    @IBOutlet var leftArrow: UIImageView!
    @IBOutlet var rightArrow: UIImageView!
    @IBOutlet var logoFull: UIImageView!
    var animationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = NSBundle.mainBundle().loadNibNamed("AnimationView", owner: self, options: nil)[0] as UIView
        animationView.frame = UIScreen.mainScreen().bounds
        self.animationView = animationView
        self.logoFull.transform = CGAffineTransformMakeScale(0, 0)
        self.view.addSubview(animationView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.logoFull.transform = CGAffineTransformIdentity
            }, completion: nil)
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.25, options: .CurveEaseInOut, animations: { () -> Void in
            self.leftArrow.transform = CGAffineTransformMakeTranslation(-self.view.frame.width, 0)
            self.rightArrow.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.animationView.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.animationView.removeFromSuperview()
                })
        })
    }
}