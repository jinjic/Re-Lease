//
//  UIImage+ColorMask.swift
//  Studies
//
//  Created by Alois Barreras on 11/5/14.
//  Copyright (c) 2014 Alois Barreras. All rights reserved.
//

import Foundation

extension UIImage {
    func maskImageWithColor(maskColor: UIColor) -> UIImage? {
        let imageRect = CGRectMake(0, 0, self.size.width, self.size.height)
        var newImage: UIImage? = nil
        
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, self.scale)
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -(imageRect.size.height))
        CGContextClipToMask(context, imageRect, self.CGImage)
        CGContextSetFillColorWithColor(context, maskColor.CGColor)
        CGContextFillRect(context, imageRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}