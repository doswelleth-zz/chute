//
//  Appearance.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

enum Appearance {
    
    static var customBackground = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static var lightBackground = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    
    static func setUpAppearance() {
        UILabel.appearance().tintColor = .black
        UITextField.appearance().tintColor = .black
    }
    
    static func applicationFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let result = UIFont(name: "REZ", size: pointSize)!
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: result)
    }
    
}
