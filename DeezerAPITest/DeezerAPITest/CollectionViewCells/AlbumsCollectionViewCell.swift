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
    
    var cellAlbum : AlbumBasic! { didSet {
        populateCell()
        }}
    var cellArtist : Artist! { didSet {
        artist.text = cellArtist.name
        }}

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel! { didSet {
        albumTitle.font = .emphasized
        albumTitle.textColor = .textStandard
        }}
    @IBOutlet weak var artist: UILabel! { didSet {
        artist.font = .detail
        artist.textColor = .textDetail
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .black
        self.selectedBackgroundView = bgColorView
    }
    
    func populateCell() {
        albumImage.fromUrl(cellAlbum.coverMedium ?? "")
        albumTitle.text = cellAlbum.title
    }

}
