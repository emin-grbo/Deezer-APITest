//
//  AlbumsViewModel.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation
import UIKit

class AlbumsViewModel {
    
    @Published var albums : [Album]?
               var artist : Artist
               var next   : String? = nil
    
    init(artist: Artist) {
        self.artist = artist
        getArtistAlbums()
    }
    
    func getArtistAlbums(paginationActive: Bool = false) {
        
        // If pagination is not active, seach for the term, else, get the next url if there is any.
        let searchTerm = paginationActive ? next : String(format: ApiService.ApiCall.artistAlbums.urlString, "\(artist.id)")
        
        // If user requested next page and there is none, return but invoke a didSet.
        if paginationActive && next == nil {
            albums = albums ?? albums
            return
        }
        
        ApiService.getAlbums(searchTerm ?? "") { (result: (Result<ApiResponse<Album>, APIError>)) in
            switch result {
            case .success(let response):
                if paginationActive {
                    self.albums?.append(contentsOf: response.data!)
                    self.next = response.next
                } else {
                    self.albums = response.data == nil ? [Album]() : response.data
                    self.next = response.next
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func topBarTitle() -> UILabel {
        let label = UILabel()
        let currentArtist = artist
        
        let artist = NSMutableAttributedString(string: currentArtist.name ?? "")
        let albumsStringAttributes = [NSAttributedString.Key.foregroundColor: UIColor.semanticTextDetail]
        let albumsString = NSMutableAttributedString(string: "\nAlbums", attributes: albumsStringAttributes)
        artist.append(albumsString)
        label.attributedText = artist
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }
    
}
