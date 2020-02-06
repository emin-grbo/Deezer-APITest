//
//  ApiService_Albums.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension ApiService {
    
    static func getAlbums(_ artistID: Int, result: @escaping (Result<ApiResponse<Album>, APIError>) -> ()) {
        // Completing the URL with artist search term
        let url = String(format: ApiService.ApiCall.artistAlbums.urlString, "\(artistID)")
        ApiService.fetchResources(urlString: url, completion: result)
    }
}
