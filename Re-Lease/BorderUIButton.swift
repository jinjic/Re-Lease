//
//  BorderUIButton.swift
//  Studies
//
//  Created by Alois Barreras on 10/7/14.
//  Copyright (c) 2014 Alois Barreras. All rights reserved.
//

import UIKit

@IBDesignable
class BorderUIButton: UIButton {

    @IBInspectable
    var borderColor: UIColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0)
    @IBInspectable
    var cornerRadius: CGFloat = 3
    @IBInspectable
    var borderWidth: CGFloat = 1
    
    override var enabled: Bool {
        didSet {
            if self.enabled == false {
                self.borderColor = UIColor.lightGrayColor()
                self.setNeedsDisplay()
            }
        }
    }
    
    override func drawRect(rect: CGRect)
    {
        self.layer.borderColor = self.borderColor.CGColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
    }
}
