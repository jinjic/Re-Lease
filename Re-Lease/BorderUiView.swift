//
//  BorderUiView.swift
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

@IBDesignable
class BorderUiView: UIView {

    @IBInspectable
    var borderColor: UIColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0)
    @IBInspectable
    var cornerRadius: CGFloat = 3
    @IBInspectable
    var borderWidth: CGFloat = 1
    
    override func drawRect(rect: CGRect)
    {
        self.layer.borderColor = self.borderColor.CGColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
    }
}
