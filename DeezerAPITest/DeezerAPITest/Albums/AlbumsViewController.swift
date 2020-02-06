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
        print(albums)
        }}
    
    weak var coordinator: MainCoordinator!
    let albumCell = String(describing: AlbumsCollectionViewCell.self)
    
    // MARK: Outlets --------------------
    @IBOutlet weak var collectionView: UICollectionView! { didSet {
        collectionView.delegate = self
        collectionView.dataSource = self
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
        bindViewModel()
    }
    
    func setupViews() {
        view.backgroundColor = .background
    }
    
    func bindViewModel() {
        cancelable = viewModel.$albums
        .delay(for: .milliseconds(250), scheduler: DispatchQueue.main)
        .receive(on: DispatchQueue.main)
        .assign(to: \.albums, on: self)
    }
    
    func refreshViews() {
        DispatchQueue.main.async {
            // Reloading views
            self.collectionView.reloadData()
            self.collectionView.hideLoader()
        }
    }

}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCell, for: indexPath) as! AlbumsCollectionViewCell
//        cell.album = albums?[indexPath.row]
        cell.albumImage.fromUrl(albums?[indexPath.row].cover ?? "")
        cell.albumTitle.text = albums?[indexPath.row].title
        cell.artist.text = "Artist"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.width/2 - 16
        return CGSize(width: cellWidth, height: cellWidth + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    
}
