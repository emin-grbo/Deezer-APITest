//
//  AlbumsViewModel.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

class AlbumsViewModel {
    
    @Published var albums : [AlbumBasic]?
    var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
        getArtistAlbums()
    }
    
    private func getArtistAlbums() {
        ApiService.getAlbums(artist.id) { (result: (Result<ApiResponse<AlbumBasic>, APIError>)) in
            switch result {
            case .success(let response):
                self.albums = response.data == nil ? [AlbumBasic]() : response.data
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
