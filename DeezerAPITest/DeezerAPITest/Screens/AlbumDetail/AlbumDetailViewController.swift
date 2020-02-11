//
//  AlbumDetailViewController.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 07/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit
import Combine
import AVFoundation

class AlbumDetailViewController: UIViewController {

    var coordinator : MainCoordinator
    var viewModel   : AlbumDetailViewModel
    var cancelable  : AnyCancellable?
    var player      : AVPlayer?

    var trackList : [Track]? { didSet {
        refreshViews()
        }}
    
    let trackCell = String(describing: TrackTableViewCell.self)
    
    @IBOutlet weak var albumCover: UIImageView! { didSet {
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopPreview))
        albumCover?.addGestureRecognizer(tap)
        }}
    @IBOutlet weak var tableView: UITableView! { didSet {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .semanticBackground
        tableView.register(UINib(nibName: trackCell, bundle: nil), forCellReuseIdentifier: trackCell)
        }}
    
    // MARK: Initialization --------------------
    init(coordinator: MainCoordinator, viewModel: AlbumDetailViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func setupViews() {
        tableView.showLoader()
        view.backgroundColor = .semanticBackground
        tableView.separatorColor = .semanticSeparator
        topBarSetup()
    }
    
    func bindViewModel() {
        cancelable = viewModel.$allTracks
        .receive(on: DispatchQueue.main)
        .assign(to: \.trackList , on: self)
    }
    
    func refreshViews() {
        tableView.reloadData()
        self.hideLoadingView()
        albumCover.fromUrl(viewModel.albumDetails?.coverBig ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopPreview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopPreview()
    }
    
    func playAudioPreview(url : URL) {
        tableView.deselectAllRows(animated: true)
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }
        catch {
            fatalError("playback failed")
        }
        player = AVPlayer(url: url)
        player?.play()
        albumCover?.startPlayingPreview()
    }
    
    @objc func stopPreview() {
        albumCover?.stopPlayingPreview()
        tableView.deselectAllRows(animated: true)
        player?.pause()
    }

}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trackList?.last?.diskNumber ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: .zero)
        header.backgroundColor = .semanticHeader
        
        let volumeLabel = UILabel(frame: CGRect(origin: CGPoint(x: 8, y: 0), size: CGSize(width: view.frame.width, height: 32)))
        volumeLabel.font = .standard
        volumeLabel.textColor = .semanticTextStandard
        volumeLabel.text = "Volume \(section + 1)"
        
        header.addSubview(volumeLabel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Returning right away if there is only one disc.
        if trackList?.last?.diskNumber == 1 { return trackList?.count ?? 0 }
        
        // Determening how many sections there are, if any.
        guard let numOfSections = trackList?.last?.diskNumber else { return 0 }
        
        for sectionNum in 0...numOfSections {
            if section == sectionNum {
                return trackList?.filter({$0.diskNumber == sectionNum + 1}).count ?? 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trackCell, for: indexPath) as! TrackTableViewCell

        guard let numOfSections = trackList?.last?.diskNumber else { return UITableViewCell() }
        
        // Determening which section is current and getting the right tracklist.
        for sectionNum in 0...numOfSections {
            if indexPath.section == sectionNum {
                let currentVolume = trackList?.filter({$0.diskNumber == sectionNum + 1})
                cell.track = currentVolume?[indexPath.row]
                return cell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                tableView.hideLoader()
            }
        }
    }
    
    // MARK: Plating audio preview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: trackList?[indexPath.row].preview ?? "") else { return }
        playAudioPreview(url: url)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
    }
}


// Cell sorting in case it is needed, eventho API seems to return tracks already ordered in all cases.
// Checking if there is a trackPosition else just return the cell as is.
//guard trackList?[indexPath.row].trackPosition != nil else {
//    cell.track = currentVolume?[indexPath.row]
//    return cell
//}
//
//// Re-ordering tracks if needed. Most API results are sorted, but just being safe.
//// Using forceUnwrap as it was checked for nil beforehand
//let sortedVolume = currentVolume?.sorted(by: {$0.trackPosition! < $1.trackPosition!})
//cell.track = sortedVolume?[indexPath.row]
//return cell
