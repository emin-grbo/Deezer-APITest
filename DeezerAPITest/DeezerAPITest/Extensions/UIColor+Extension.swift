//
//  UIColor+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: Class variables ---------------------------------------
    class var background:      UIColor { return UIColor(hex: "#232323FF")! }
    
    // MARK: HEX value initialization methods ---------------------------------------
    convenience init(rgbColorRed red: Double, green: Double, blue: Double, alpha: Double) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255,
                  alpha: CGFloat(alpha))
    }

    convenience init(_ red: Double, _ green: Double, _ blue: Double) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255,blue: CGFloat(blue)/255,
                  alpha: CGFloat(1.0))
    }

    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber  & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
