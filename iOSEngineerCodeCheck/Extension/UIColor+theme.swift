//
//  UIColor+theme.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/09.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIColor{

    static let backgroundColor = ldColor(UIColor(hex: "F2F4F7"), UIColor(hex: "1E2127"))
    static let secondaryBackgroundColor = ldColor(.white, UIColor(hex: "252830"))
    
    static let tertiaryLabelColor = ldColor(UIColor(hex: "6F799D"), UIColor(hex: "B7C1C9"))
    
    static func ldColor(_ light:UIColor, _ dark:UIColor) -> UIColor{
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                dark:
                light
        }
    }
}
