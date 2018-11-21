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
    
    static func setUpAppearance() {
        UINavigationBar.appearance().barTintColor = Appearance.customBackground
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        UILabel.appearance().tintColor = Appearance.customBackground
        UITextField.appearance().tintColor = Appearance.customBackground
    }
    
    static func applicationFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let result = UIFont(name: "REZ", size: pointSize)!
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: result)
    }
    
}
