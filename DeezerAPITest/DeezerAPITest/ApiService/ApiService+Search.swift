//
//  ApiService+Search.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension ApiService {
    
    static func searchArtists(_ artist: String, result: @escaping (Result<ApiResponse<Artist>, APIError>) -> ()) {
        // Completing the URL with artist search term
        let url = ApiService.ApiCall.search.urlString + artist
        ApiService.fetchResources(urlString: url, completion: result)
    }
}
