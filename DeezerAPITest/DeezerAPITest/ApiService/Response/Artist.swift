//
//  Artist.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

struct Artist : Codable, Hashable {
    let id : Int
    let name : String?
    let pictureMedium : String?
    let numAlbum : Int?
//    let link : String?
//    let picture : String?
//    let pictureSmall : String?
//    let pictureBig : String?
//    let pictureXl : String?
//    let numFan : Int?
//    let radio : Bool?
//    let tracklist : String?
//    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pictureMedium = "picture_medium"
        case numAlbum = "nb_album"
//        case link
//        case picture
//        case pictureSmall = "picture_small"
//        case pictureBig = "picture_big"
//        case pictureXl = "picture_xl"
//        case numFan = "nb_fan"
//        case radio
//        case tracklist
//        case type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//extension Artist {
//    func ==
//}
