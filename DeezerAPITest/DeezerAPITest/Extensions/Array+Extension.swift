//
//  Array+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 10/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
