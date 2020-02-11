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
    
    @Published var allTracks    : [Track]?
    var albumDetails : Album?
    var trackLimit : Int?
    let albumID : Int
    
    init(albumID: Int) {
        self.albumID = albumID
        getAlbumDetail()
    }
    
    func getAlbumDetail() {
        ApiService.getSingleAlbumDetail("\(albumID)") { (result: (Result<Album, APIError>)) in
            switch result {
            case .success(let response):
                self.albumDetails = response
                self.trackLimit = self.albumDetails?.numOfTracks
                self.getAllTracks()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getAllTracks() {
        guard trackLimit != nil else { return }
        ApiService.getAllTracks("\(albumID)", limit: trackLimit!) { (result: (Result<ApiResponse<Track>, APIError>)) in
            switch result {
            case .success(let response):
                self.allTracks = response.data
            case .failure(let error):
                print(error)
            }
        }
    }
}
