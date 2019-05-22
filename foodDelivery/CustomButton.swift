//
//  CustomButton.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton:UIButton{
    override func didMoveToWindow() {
        self.backgroundColor = UIColor.red
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
