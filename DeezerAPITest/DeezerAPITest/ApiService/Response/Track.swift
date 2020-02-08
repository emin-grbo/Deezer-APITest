//
//  Tracklist.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 07/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

struct Track : Codable {
    let id : Int?
    let title : String?
    let title_short : String?
    let link : String?
    let duration : Int?
    let artist : Artist?
    let track_position : Int?
    let disk_number : Int?
    //let title_version : String?
    //let readable : Bool?
    //let rank : String?
    //let explicit_lyrics : Bool?
    //let explicit_content_lyrics : Int?
    //let explicit_content_cover : Int?
    //let preview : String?
    //let type : String?

enum CodingKeys: String, CodingKey {

    case id = "id"
    case title = "title"
    case title_short = "title_short"
    case link = "link"
    case duration = "duration"
    case artist = "artist"
    case track_position = "track_position"
    case disk_number = "disk_number"
//    case readable = "readable"
//    case title_version = "title_version"
//    case rank = "rank"
//    case explicit_lyrics = "explicit_lyrics"
//    case explicit_content_lyrics = "explicit_content_lyrics"
//    case explicit_content_cover = "explicit_content_cover"
//    case preview = "preview"
//    case type = "type"
}
}
