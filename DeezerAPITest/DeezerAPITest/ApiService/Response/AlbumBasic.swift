//
//  Album.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

struct AlbumBasic : Codable {
    let id : Int
    let title : String?
    let link : String?
    let cover : String?
    let cover_small : String?
    let cover_medium : String?
    let cover_big : String?
    let cover_xl : String?
    let genre_id : Int?
    let fans : Int?
    let release_date : String?
    let record_type : String?
    let tracklist : String?
    let explicit_lyrics : Bool?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case link = "link"
        case cover = "cover"
        case cover_small = "cover_small"
        case cover_medium = "cover_medium"
        case cover_big = "cover_big"
        case cover_xl = "cover_xl"
        case genre_id = "genre_id"
        case fans = "fans"
        case release_date = "release_date"
        case record_type = "record_type"
        case tracklist = "tracklist"
        case explicit_lyrics = "explicit_lyrics"
        case type = "type"
    }
}
