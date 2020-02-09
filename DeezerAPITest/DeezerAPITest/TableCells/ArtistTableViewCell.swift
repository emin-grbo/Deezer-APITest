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
        artistName.textColor = .textStandard
        artistName.font = .standard
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .background
        // Making the selected view black
        let bgColorView = UIView()
        bgColorView.backgroundColor = .black
        self.selectedBackgroundView = bgColorView
    }
    
    func setupCell() {
        artistImage.image = nil
        artistName.text = artist.name
        artistImage.fromUrl(artist.pictureMedium ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
