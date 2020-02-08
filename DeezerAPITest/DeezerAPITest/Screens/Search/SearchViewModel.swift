//
//  SearchViewModel.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 05/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

class SearchViewModel {
    @Published var artists : [Artist]?
    var term : String! { didSet {
        getArtists()
        }}
    
    func getArtists() {
        ApiService.searchArtists(term) { (result: (Result<ApiResponse<Artist>, APIError>)) in
            switch result {
            case .success(let response):
                self.artists = response.data == nil ? [Artist]() : response.data
            case .failure(let error):
                print(error)
            }
        }
    }
}
