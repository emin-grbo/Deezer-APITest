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
               var next    : String? = nil
               var term    : String!
    
    func getArtists(paginationActive: Bool = false) {
        
        // If pagination is not active, seach for the term, else, get the next url if there is any.
        let searchTerm = paginationActive ?  next : ApiService.ApiCall.search.urlString + term
        
        // If user requested next page and there is none, return but invoke a didSet.
        if paginationActive && next == nil {
            self.artists = artists ?? artists
            return
        }
        
        ApiService.searchArtists(searchTerm ?? "") { (result: (Result<ApiResponse<Artist>, APIError>)) in
            switch result {
               
            case .success(let response):
                if paginationActive {
                    self.artists?.append(contentsOf: response.data!)
                    self.next = response.next
                } else {
                    self.artists = response.data == nil ? [Artist]() : response.data
                    self.next = response.next
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
