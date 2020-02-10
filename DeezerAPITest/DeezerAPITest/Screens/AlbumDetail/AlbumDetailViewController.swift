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
        self.hideLoadingView()
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
        do{
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }
        catch{
            fatalError("playback failed")
        }
        
        player = AVPlayer(url: url)
        player?.volume = 1
        player?.play()
        header?.startPlayingPreview()
    }
    
    @objc func stopPreview() {
        header?.stopPlayingPreview()
        tableView.deselectAllRows(animated: true)
        player?.pause()
    }

}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenWidth = view.frame.width
        header = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        header?.isUserInteractionEnabled = true
        header?.fromUrl(viewModel.album.coverBig ?? "")
        header?.clipsToBounds = true
        header?.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        header?.addGestureRecognizer(tap)
        return header
    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer) {
        stopPreview()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.width
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
    
    // MARK: Plating audio preview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: tracklist?[indexPath.row].preview ?? "") else { return }
        playAudioPreview(url: url)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
    }
    
    // Pagination call
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollHeight = scrollView.frame.size.height
        
        if offset > contentHeight - scrollHeight * 1.2 {
            showPaginationLoader()
            viewModel.getTracklist(paginationActive: true)
        }
    }


}
