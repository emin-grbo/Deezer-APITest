//
//  AlbumDetailViewModel.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 08/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailViewModel {
    
    @Published var tracks: [Track]?
    let album: AlbumBasic
    
    init(album: AlbumBasic) {
        self.album = album
        getTracklist()
    }
    
    func getTracklist() {
        ApiService.getTracklist(album.tracklist ?? "") { (result: (Result<ApiResponse<Track>, APIError>)) in
            switch result {
            case .success(let response):
                self.tracks = response.data == nil ? [Track]() : response.data
            case .failure(let error):
                print(error)
            }
        }
    }
}
