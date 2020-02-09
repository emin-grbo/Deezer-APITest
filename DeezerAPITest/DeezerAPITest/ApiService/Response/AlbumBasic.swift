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
    let coverMedium : String?
    let tracklist : String?
    let coverBig : String?
//    let link : String?
//    let cover : String?
//    let cover_small : String?
//    let cover_xl : String?
//    let genre_id : Int?
//    let fans : Int?
//    let release_date : String?
//    let record_type : String?
//    let explicit_lyrics : Bool?
//    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverMedium = "cover_medium"
        case tracklist
        case coverBig = "cover_big"
//        case link
//        case cover
//        case cover_small = "cover_small"
//        case cover_xl = "cover_xl"
//        case genre_id = "genre_id"
//        case fans = "fans"
//        case release_date = "release_date"
//        case record_type = "record_type"
//        case explicit_lyrics = "explicit_lyrics"
//        case type = "type"
    }
}
