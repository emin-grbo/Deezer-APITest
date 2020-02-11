//
//  AlbumsViewController.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 05/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit
import Combine

class AlbumsViewController: UIViewController {

    // MARK: Variables --------------------
    var viewModel: AlbumsViewModel!
    var cancelable: AnyCancellable?
    
    var albums: [Album]? { didSet {
        refreshViews()
        }}
    
    weak var coordinator: MainCoordinator!
    let albumCell = String(describing: AlbumsCollectionViewCell.self)
    
    // MARK: Outlets --------------------
    @IBOutlet weak var collectionView: UICollectionView! { didSet {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .semanticBackground
        collectionView.register(UINib(nibName: albumCell, bundle: nil), forCellWithReuseIdentifier: albumCell)
        }}
    
    // MARK: Initialization --------------------
    init(coordinator: MainCoordinator, viewModel: AlbumsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    // ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showLoader()
        setupViews()
        navBarSetup()
        bindViewModel()
    }
    
    func setupViews() {
        view.backgroundColor = .semanticBackground
        topBarSetup()
    }
    
    func navBarSetup() {
        // Handling 2 lines for navigation bar with "Albums" string
        self.navigationItem.titleView = viewModel.topBarTitle()
    }
    
    func bindViewModel() {
        cancelable = viewModel.$albums
        .receive(on: DispatchQueue.main)
        .assign(to: \.albums, on: self)
    }
    
    func refreshViews() {
        DispatchQueue.main.async {
            // Reloading views
            self.collectionView.reloadData()
            self.collectionView.hideLoader()
            self.hideLoadingView()
        }
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCell, for: indexPath) as! AlbumsCollectionViewCell
        
        let currentAlbum = albums?[indexPath.row]
        let currentArtist = viewModel.artist
        
        cell.cellAlbum = currentAlbum
        cell.cellArtist = currentArtist
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // Opening detail page for the selected album
        guard let tappedAlbum = albums?[indexPath.row] else { return}
        coordinator.openAlbumDetalPage(album: tappedAlbum)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.width/2 - 16
        return CGSize(width: cellWidth, height: cellWidth + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    // Pagination call
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollHeight = scrollView.frame.size.height
        
        if offset > contentHeight - scrollHeight * 1.2 {
            showPaginationLoader()
            viewModel.getArtistAlbums(paginationActive: true)
        }
    }
    
    
}
