//
//  NameLabel.swift
//  pokedex
//
//  Created by Stefan Blos on 25.01.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit

class NameLabel: UILabel {

    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }

}
