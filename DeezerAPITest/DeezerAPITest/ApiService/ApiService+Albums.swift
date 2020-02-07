//
//  ApiService_Albums.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

extension ApiService {
    
    static func getAlbums(_ artistID: Int, result: @escaping (Result<ApiResponse<AlbumBasic>, APIError>) -> ()) {
        // Completing the URL with artist search term
        let url = String(format: ApiService.ApiCall.artistAlbums.urlString, "\(artistID)")
        ApiService.fetchResources(urlString: url, completion: result)
    }
    
    static func getSingleAlbum(_ albumID: Int, result: @escaping (Result<AlbumDetail, APIError>) -> ()) {
        // Completing the URL with artist search term
        let url = String(format: ApiService.ApiCall.album.urlString, "\(albumID)")
        ApiService.fetchResources(urlString: url, completion: result)
    }
}
