//
//  MessagesTableView.swift
//  Vicino
//
//  Created by Alois Barreras on 3/4/15.
//  Copyright (c) 2015 Alois. All rights reserved.
//

import UIKit

class MessagesTableView: UITableView {

    private var _inputAccessoryView: KeyboardBar?
    override var inputAccessoryView: KeyboardBar? {
        get {
            return _inputAccessoryView
        }
        set {
            _inputAccessoryView = newValue
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        super.canBecomeFirstResponder()
        return true
    }
}
