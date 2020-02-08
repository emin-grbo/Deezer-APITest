//
//  UIImage+Extension.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

extension UIImageView {

    // MARK: Class variables ---------------------------------------
    class var clear:    UIImage { return UIImage(named: "clear")! }
    class var search:   UIImage { return UIImage(named: "search")! }
    
    // MARK: Methods ----------------------------------------------------
    func fromUrl(_ url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                self.hideLoader()
            }
        }.resume()
    }
    
    func fromUrl(_ link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        self.showLoader()
        guard let url = URL(string: link) else { return }
        fromUrl(url, contentMode: mode)
    }
}
