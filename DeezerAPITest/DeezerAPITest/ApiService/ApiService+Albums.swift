//
//  ApiService_Albums.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension ApiService {
    
    static func getAlbums(_ query: String, result: @escaping (Result<ApiResponse<Album>, APIError>) -> ()) {
        // Completing the URL with artist search term
        ApiService.fetchResources(urlString: query, completion: result)
    }
    
    static func getSingleAlbumDetail(_ query: String, result: @escaping (Result<Album, APIError>) -> ()) {
        // Completing the URL with artist search term
        let url = String(format: ApiService.ApiCall.album.urlString, query)
        ApiService.fetchResources(urlString: url, completion: result)
    }
}
