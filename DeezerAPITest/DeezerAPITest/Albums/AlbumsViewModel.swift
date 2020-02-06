//
//  AlbumsViewModel.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

class AlbumsViewModel {
    
    @Published var albums : [Album]?
    let artistID: Int
    
    init(artistID: Int) {
        self.artistID = artistID
        getArtistAlbums()
    }
    
    func getArtistAlbums() {
        ApiService.getAlbums(artistID) { (result: (Result<ApiResponse<Album>, APIError>)) in
            switch result {
            case .success(let response):
                self.albums = response.data == nil ? [Album]() : response.data
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
