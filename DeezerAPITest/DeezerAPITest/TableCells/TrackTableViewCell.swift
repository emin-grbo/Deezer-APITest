//
//  TrackTableViewCell.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 07/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    var track : Track! { didSet {
        populateCell()
        }}

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
        // Making the selected view black
        let bgColorView = UIView()
        bgColorView.backgroundColor = .black
        self.selectedBackgroundView = bgColorView
    }
    
    func populateCell() {
        trackOrderLabel.text = "\(track.trackPosition ?? 0)."
        trackTitleLabel.text = track.titleShort
        trackArtistLabel.text = track.artist?.name ?? "No Artist"
        trackDurationLabel.text = track.duration?.formattedTime()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
