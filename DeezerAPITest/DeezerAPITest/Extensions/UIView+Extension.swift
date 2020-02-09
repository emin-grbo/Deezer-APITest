//
//  UIView+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 09/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation
import UIKit

fileprivate var loadingContainer : UIView!

extension UIViewController {
    
    func showPaginationLoader() {
        loadingContainer = UIView(frame: view.bounds)
        view.addSubview(loadingContainer)
        
        loadingContainer.backgroundColor = .background
        loadingContainer.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            loadingContainer.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingContainer.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView() {
        // returning if loadingContainer is not present
        guard loadingContainer != nil else { return }
        
        UIView.animate(withDuration: 0.25) { loadingContainer.alpha = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            loadingContainer.removeFromSuperview()
            loadingContainer = nil
        }
    }
}
