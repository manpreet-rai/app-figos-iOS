//
//  CustomButton.swift
//  Figos
//
//  Created by Manu on 29/04/21.
//

import UIKit

class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
            UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
            self.clipsToBounds = true
        }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
