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
        trackOrderLabel.textColor = .semanticTextStandard
        }}
    @IBOutlet weak var trackTitleLabel: UILabel! { didSet {
        trackTitleLabel.font = .emphasized
        trackTitleLabel.textColor = .semanticTextStandard
        }}
    @IBOutlet weak var trackArtistLabel: UILabel! { didSet {
        trackArtistLabel.font = .detail
        trackArtistLabel.textColor = .semanticTextDetail
        }}
    @IBOutlet weak var trackDurationLabel: UILabel! { didSet {
        trackDurationLabel.font = .detail
        trackDurationLabel.textColor = .semanticTextDetail
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        // Initialization code
    }
    
    func setupViews() {
        self.backgroundColor = .semanticBackground
    }
    
    func populateCell() {
        trackOrderLabel.text = "\(track.trackPosition ?? 0)."
        trackTitleLabel.text = track.titleShort
        trackArtistLabel.text = track.artist?.name ?? "No Artist"
        trackDurationLabel.text = track.duration?.formattedTime()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = .semanticTextDetail
        } else {
            self.backgroundColor = .semanticBackground
        }
        // Configure the view for the selected state
    }
    
}
