//
//  UIHeaderFooter+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 09/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

fileprivate var playingView: UIView!
fileprivate var stopButton : UIImageView!

extension UIImageView {

    func startPlayingPreview() {
        guard playingView == nil else { return }
        
        playingView = UIView(frame: self.bounds)
        self.addSubview(playingView)
        
        playingView.backgroundColor = .background
        playingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            playingView.alpha = 0.8
        }
        
        stopButton = UIImageView()
        stopButton.image = UIImage(systemName: "stop.circle.fill")
        stopButton.tintColor = .white
        playingView.addSubview(stopButton)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.centerYAnchor.constraint(equalTo: playingView.centerYAnchor),
            stopButton.centerXAnchor.constraint(equalTo: playingView.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            stopButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func stopPlayingPreview() {
        // returning if playingView is not present
        guard playingView != nil else { return }
        UIView.animate(withDuration: 0.25) { playingView.alpha = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            playingView.removeFromSuperview()
            playingView = nil
        }
    }
}
