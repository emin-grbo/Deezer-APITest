//
//  AlbumsCollectionViewCell.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 06/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit
import Combine

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    var cellAlbum : Album! { didSet {
        populateCell()
        }}
    var cellArtist : Artist! { didSet {
        artist.text = cellArtist.name
        }}

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel! { didSet {
        albumTitle.font = .emphasized
        albumTitle.textColor = .semanticTextStandard
        }}
    @IBOutlet weak var artist: UILabel! { didSet {
        artist.font = .detail
        artist.textColor = .semanticTextDetail
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .semanticBackground
        self.selectedBackgroundView = bgColorView
    }
    
    func populateCell() {
        albumImage.fromUrl(cellAlbum.coverMedium ?? "")
        albumTitle.text = cellAlbum.title
    }

}
