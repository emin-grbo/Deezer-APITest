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
    var next : String? = nil
    
    init(album: AlbumBasic) {
        self.album = album
        getTracklist()
    }
    
    func getTracklist(paginationActive: Bool = false) {
        
        // If pagination is not active, seach for the term, else, get the next url if there is any.
        let searchTerm = paginationActive ? next : album.tracklist
        
        // If user requested next page and there is none, return but invoke a didSet.
        if paginationActive && next == nil {
            tracks = tracks ?? tracks
            return
        }
        
        ApiService.getTracklist(searchTerm ?? "") { (result: (Result<ApiResponse<Track>, APIError>)) in
            switch result {
            case .success(let response):
                if paginationActive {
                    self.tracks?.append(contentsOf: response.data!)
                    self.next = response.next
                } else {
                    self.tracks = response.data == nil ? [Track]() : response.data
                    self.next = response.next
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
