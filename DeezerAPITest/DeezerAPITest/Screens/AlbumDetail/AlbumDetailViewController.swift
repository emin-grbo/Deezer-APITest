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

    var coordinator: MainCoordinator
    var viewModel: AlbumDetailViewModel
    var cancelable: AnyCancellable?
    var player : AVPlayer?
    var header : UIImageView?
    
    var tracklist : [Track]? { didSet {
        refreshViews()
        }}
    
    let trackCell = String(describing: TrackTableViewCell.self)
    
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
    }
    
    func bindViewModel() {
        cancelable = viewModel.$tracks
        .receive(on: DispatchQueue.main)
        .assign(to: \.tracklist , on: self)
    }
    
    func refreshViews() {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        header?.stopPlayingPreview()
        player?.pause()
    }

}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenWidth = view.frame.width * 0.7
        header = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        header?.isUserInteractionEnabled = true
        header?.fromUrl(viewModel.album.coverBig ?? "")
        header?.clipsToBounds = true
        header?.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        header?.addGestureRecognizer(tap)
        return header
    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer) {
        header?.stopPlayingPreview()
        tableView.deselectAllRows(animated: true)
        player?.pause()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.width * 0.7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracklist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trackCell, for: indexPath) as! TrackTableViewCell
        guard let currentTrack = tracklist?[indexPath.row] else { return UITableViewCell() }
        cell.track = currentTrack
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.deselectAllRows(animated: true)
        
        guard let url = URL(string: tracklist?[indexPath.row].preview ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 1
        player?.play()
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        header?.startPlayingPreview()
    }

}
