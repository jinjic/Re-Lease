//
//  KeyboardBar.swift
//  Vicino
//
//  Created by Alois Barreras on 3/4/15.
//  Copyright (c) 2015 Alois. All rights reserved.
//

import UIKit

class KeyboardBar: UIView {
    
    var textField: UITextField!
    var sendButton: UIButton!

    convenience override init() {
        let screen = UIScreen.mainScreen().bounds
        let frame = CGRectMake(0,0, CGRectGetWidth(screen), 46)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.95)
        
        self.sendButton = UIButton(frame: CGRectZero)
        self.sendButton.setTitle("Send", forState: .Normal)
        self.sendButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        self.sendButton.sizeToFit()
        
        self.textField = UITextField(frame: CGRectMake(10, 8, frame.width - 25 - self.sendButton.frame.width, 30))
        self.textField.placeholder = "Message"
        self.sendButton.frame.origin = CGPointMake(CGRectGetMaxX(self.textField.frame) + 5, 7)
        self.sendButton.setTitleColor(UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0), forState: .Normal)
        
        self.textField.borderStyle = .RoundedRect
        self.addSubview(self.sendButton)
        self.addSubview(self.textField)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect))
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect))
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        CGContextSetLineWidth(context, 1.0)
        CGContextStrokePath(context)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}