//
//  TrackTableViewCell.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 07/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    // MARK: OUTLETS ------------------
    @IBOutlet weak var trackOrderLabel: UILabel! { didSet {
        trackOrderLabel.font = .Xlarge
        trackOrderLabel.textColor = .textStandard
        }}
    @IBOutlet weak var trackTitleLabel: UILabel! { didSet {
        trackTitleLabel.font = .emphasized
        trackTitleLabel.textColor = .textStandard
        }}
    @IBOutlet weak var trackArtistLabel: UILabel! { didSet {
        trackArtistLabel.font = .detail
        trackArtistLabel.textColor = .textDetail
        }}
    @IBOutlet weak var trackDurationLabel: UILabel! { didSet {
        trackDurationLabel.font = .detail
        trackDurationLabel.textColor = .textDetail
        }}
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        // Initialization code
    }
    
    func setupViews() {
        self.backgroundColor = .background
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
