//
//  MainCoordinator.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

class MainCoordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let vm = SearchViewModel()
        let vc = SearchVC(mainCoordinator: self, viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openAlbumsPage(for artist: Artist) {
        let vm = AlbumsViewModel(artist: artist)
        let vc = AlbumsViewController(coordinator: self, viewModel: vm)
        vc.title = artist.name
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openAlbumDetalPage(album: AlbumBasic) {
        let vm = AlbumDetailViewModel(album: album)
        let vc = AlbumDetailViewController(coordinator: self, viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
