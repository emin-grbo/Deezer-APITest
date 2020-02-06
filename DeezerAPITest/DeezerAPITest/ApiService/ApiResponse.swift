//
//  ApiResponse.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let data : [T]?
    let total : Int?
    let next : String?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case total = "total"
        case next = "next"
    }
}
