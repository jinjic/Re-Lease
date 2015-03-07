//
//  IndiePostViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit

class IndiePostViewController: UIViewController {
    
    var image = UIImageView(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
    var displayView = UIView(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
    var constraints: [NSLayoutConstraint] = []
    var whiteConstraints: [NSLayoutConstraint] = []
    var waterImage = UIImageView(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
    var eletricImage = UIImageView(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
    var heatImage = UIImageView(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "$0"
        label.textAlignment = .Center
        label.font = UIFont(name: "Arial", size: 30)
        label.textColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 100)

        
        return label
        }()
    
    lazy var AddressLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "Address:"
        label.textAlignment = .Center
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = UIColor(red: 112/255, green: 164/255, blue: 182/255, alpha: 100)

        
        return label
        }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "date:"
        label.textAlignment = .Center
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = UIColor(red: 167/255, green: 202/255, blue: 215/255, alpha: 100)

        
        return label
        }()
    
    lazy var sendMessageButton: UIButton = {
        let button = UIButton(frame: CGRectMake(0.0, 0.0, 100.0, 20.0))
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("Interested? Send a message.", forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.setTitleColor(UIColor(red: 94/255, green: 147/255, blue: 167/255, alpha: 100), forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFill
        button.layer.borderWidth = 2.0
        button.layer.borderColor = (UIColor(red: 94/255, green: 147/255, blue: 167/255, alpha: 100)).CGColor
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: Selector("sendMessageClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
        }()
    
    var post: Post!
    var selMake = String()
    var tableData : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addConstraints()
    }
    
    func addViews() {
        image.setTranslatesAutoresizingMaskIntoConstraints(false)
        image.image = UIImage(named: "josipsucks1")
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 100)
        displayView.setTranslatesAutoresizingMaskIntoConstraints(false)
        displayView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 100)
        displayView.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 100).CGColor
        displayView.layer.borderWidth = 0.5
        displayView.layer.cornerRadius = 8
        self.view.addSubview(image)
        self.view.addSubview(displayView)
        self.view.addSubview(sendMessageButton)
        
        displayView.addSubview(priceLabel)
        displayView.addSubview(AddressLabel)
        displayView.addSubview(dateLabel)
        waterImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        waterImage.image = UIImage(named: "water-selected")
        eletricImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        eletricImage.image = UIImage(named: "electric-selected")
        heatImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        heatImage.image = UIImage(named: "gas-selected")
        
        displayView.addSubview(waterImage)
        displayView.addSubview(eletricImage)
        displayView.addSubview(heatImage)
        
    }
    
    func addConstraints() {
        self.addViews()
        
        let mainView: [NSObject:AnyObject] = ["image": image,"display": displayView,"button": sendMessageButton, "top": self.topLayoutGuide]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: nil, metrics: nil, views: mainView) as [NSLayoutConstraint]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[display]-20-|", options: nil, metrics: nil, views: mainView) as [NSLayoutConstraint]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[button]-50-|", options: nil, metrics: nil, views: mainView) as [NSLayoutConstraint]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:[top][image(==200)]-31-[display(>=150)]", options: nil, metrics: nil, views: mainView) as [NSLayoutConstraint]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:[button]-15-|", options: nil, metrics: nil, views: mainView) as [NSLayoutConstraint]
        NSLayoutConstraint.activateConstraints(constraints)
        
        let whiteView: [NSObject:AnyObject] = ["price": priceLabel, "date": dateLabel,"water": waterImage, "eletric": eletricImage, "heat": heatImage, "address": AddressLabel]
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[price]-40-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[address]-40-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[date]-40-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-110-[water(eletric)]-[eletric(heat)]-[heat(20)]-110-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[price]-[address]-5-[eletric(water)]-5-[date]-30-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[price]-[address]-5-[water(heat)]-5-[date]-30-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        whiteConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[price]-[address]-5-[heat(32)]-5-[date]-30-|", options: nil, metrics: nil, views: whiteView) as [NSLayoutConstraint]
        NSLayoutConstraint.activateConstraints(whiteConstraints)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
