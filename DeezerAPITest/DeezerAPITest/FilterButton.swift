//
//  FilterButton.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 09/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

class FilterButton: UIViewFromNib {

    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterTitle: UILabel!

    init(frame: CGRect, title: String, image: UIImage) {
        super.init(frame: frame)
        self.filterTitle.text = title.uppercased()
        self.filterImage.image = image
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = .background
        tintColor = .white
        filterTitle.textColor = .white
    }
    
}
