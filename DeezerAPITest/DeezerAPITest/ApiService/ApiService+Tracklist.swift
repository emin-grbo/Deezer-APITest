//
//  ApiService+Tracklist.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 07/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension ApiService {
    static func getTracklist(_ query: String, result: @escaping (Result<ApiResponse<Track>, APIError>) -> ()) {
        // Completing the URL with artist search term
        ApiService.fetchResources(urlString: query, completion: result)
    }
}
