//
//  AttributeLabel.swift
//  pokedex
//
//  Created by Stefan Blos on 28.01.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit

class AttributeLabel: UILabel {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        layer.cornerRadius = 3.0
        clipsToBounds = true
    }
    

}
