//
//  ApiService+Search.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension ApiService {
    
    static func searchArtists(_ query: String, result: @escaping (Result<ApiResponse<Artist>, APIError>) -> ()) {
        ApiService.fetchResources(urlString: query, completion: result)
    }
}
