//
//  UIFont+Extensions.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit.UIFont

extension UIFont {

// MARK: Bold
    class var standard:    UIFont { return systemFont(ofSize: 17, weight: .medium) }
    class var emphasized:  UIFont { return systemFont(ofSize: 18, weight: .bold) }
    class var detail:      UIFont { return systemFont(ofSize: 15, weight: .regular) }
}
