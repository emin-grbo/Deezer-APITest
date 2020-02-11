//
//  ArtistTableViewCell.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    var artist: Artist! { didSet {
        setupCell()
        }}

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel! { didSet {
        artistName.textColor = .semanticTextStandard
        artistName.font = .standard
        }}
    @IBOutlet weak var noAlbumsLabel: UILabel! { didSet {
        noAlbumsLabel.text = "no known albums"
        noAlbumsLabel.font = .detail
        noAlbumsLabel.textColor = .semanticTextDetail
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .semanticBackground
    }
    
    func setupCell() {
        artistImage.image = nil
        artistName.text = artist.name
        artistImage.fromUrl(artist.pictureMedium ?? "")
        if artist.numAlbum == 0 {
            noAlbumsLabel.isHidden = false
            self.isUserInteractionEnabled = false
        } else {
            noAlbumsLabel.isHidden = true
            self.isUserInteractionEnabled = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
