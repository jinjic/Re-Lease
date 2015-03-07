//
//  GroupDetailIncomingMessageTableViewCell.swift
//  Studies
//
//  Created by Alois Barreras on 11/6/14.
//  Copyright (c) 2014 Alois Barreras. All rights reserved.
//

import UIKit

class IncomingMessageTableViewCell: UITableViewCell {

    @IBOutlet var messageBodyLabel: UILabel!
    @IBOutlet var bubbleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bubbleImageView.image = self.bubbleImageView.image!.maskImageWithColor(UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0))
    }
}