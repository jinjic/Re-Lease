//
//  GroupDetailMessageTableViewCell.swift
//  Studies
//
//  Created by Alois Barreras on 10/28/14.
//  Copyright (c) 2014 Alois Barreras. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet var messageBodyLabel: UILabel!
    @IBOutlet var bubbleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bubbleImageView.image = self.bubbleImageView.image!.maskImageWithColor(UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0))
    }
}