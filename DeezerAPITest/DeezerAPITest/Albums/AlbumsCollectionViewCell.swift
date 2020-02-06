//
//  AlbumsCollectionViewCell.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit



class AlbumsCollectionViewCell: UICollectionViewCell {
    
    var album : Album! // To be used.

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel! { didSet {
        albumTitle.font = .emphasized
        albumTitle.textColor = .textStandard
//        albumTitle.text = albumTitle.text?.uppercased()
        }}
    @IBOutlet weak var artist: UILabel! { didSet {
        artist.font = .detail
        artist.textColor = .textDetail
        }}
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
