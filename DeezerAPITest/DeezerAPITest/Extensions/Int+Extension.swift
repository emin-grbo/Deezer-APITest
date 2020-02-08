//
//  Int+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 08/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension Int {
    func formattedTime() -> String {
        let seconds = self % 60
        let minutes = (self / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
