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
    let titleShort : String?
    let duration : Int?
    let artist : Artist?
    let trackPosition : Int?
    let diskNumber : Int?
    let preview : String?
    //let link : String?
    //let title : String?
    //let title_version : String?
    //let readable : Bool?
    //let rank : String?
    //let explicit_lyrics : Bool?
    //let explicit_content_lyrics : Int?
    //let explicit_content_cover : Int?
    //let type : String?

enum CodingKeys: String, CodingKey {
    case id
    case titleShort = "title_short"
    case duration
    case artist
    case trackPosition = "track_position"
    case diskNumber = "disk_number"
    case preview
//    case link = "link"
//    case title = "title"
//    case readable = "readable"
//    case title_version = "title_version"
//    case rank = "rank"
//    case explicit_lyrics = "explicit_lyrics"
//    case explicit_content_lyrics = "explicit_content_lyrics"
//    case explicit_content_cover = "explicit_content_cover"
//    case type = "type"
}
}
