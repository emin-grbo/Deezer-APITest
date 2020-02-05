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
        let vc = SearchVC(mainCoordinator: self)
        navigationController.pushViewController(vc, animated: true)
//        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .searchIcon, style: .plain, target: self, action: #selector(searchTapped))
//        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .radioIcon, style: .plain, target: self, action: #selector(playRadioStream))
    }
}
