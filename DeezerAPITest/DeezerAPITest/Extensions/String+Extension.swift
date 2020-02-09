//
//  String+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 08/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension String {
    func truncateTo(_ limit: Int) -> String {
        var truncated = self
        
        if truncated.count > limit {
            while truncated.count >= limit {
                truncated.remove(at: truncated.index(before: truncated.endIndex))
            }
            truncated.append("...")
        }
        return truncated
    }
}
