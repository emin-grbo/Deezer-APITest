//
//  AlbumDetailViewController.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 07/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit
import Combine

class AlbumDetailViewController: UIViewController {

    var coordinator: MainCoordinator
    var viewModel: AlbumDetailViewModel
    var cancelable: AnyCancellable?
    
    var tracklist : [Track]? { didSet {
        refreshViews()
        }}
    
    let trackCell = String(describing: TrackTableViewCell.self)
    
    @IBOutlet weak var tableView: UITableView! { didSet {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .background
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
        view.backgroundColor = .background
        tableView.separatorColor = .separatorDark
    }
    
    func bindViewModel() {
        cancelable = viewModel.$tracks
        .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .receive(on: DispatchQueue.main)
        .assign(to: \.tracklist , on: self)
    }
    
    func refreshViews() {
        tableView.reloadData()
    }

}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenWidth = view.frame.width
        let header = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        header.fromUrl(viewModel.album.coverBig ?? "")
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        headerView.backgroundColor = .red
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
