//
//  Artist.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

struct Artist : Codable {
    let id : Int
    let name : String?
    let link : String?
    let picture : String?
    let pictureSmall : String?
    let pictureMedium : String?
    let pictureBig : String?
    let pictureXl : String?
    let numAlbum : Int?
    let numFan : Int?
    let radio : Bool?
    let tracklist : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case link
        case picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case numAlbum = "nb_album"
        case numFan = "nb_fan"
        case radio
        case tracklist
        case type
    }
}
