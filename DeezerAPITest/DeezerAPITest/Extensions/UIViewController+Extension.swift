//
//  UIViewController+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 11/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

extension UIViewController {
    func topBarSetup() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBar.backgroundColor = .semanticHeader
        window?.addSubview(statusBar)
    }
}
