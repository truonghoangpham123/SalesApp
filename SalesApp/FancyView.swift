//
//  FancyView.swift
//  SalesApp
//
//  Created by Mac-ninjaKID on 11/28/16.
//  Copyright © 2016 KobePham. All rights reserved.
// abc testing

import UIKit

class FancyView: UIView {

    override func awakeFromNib(){
        super.awakeFromNib()

        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }


}
