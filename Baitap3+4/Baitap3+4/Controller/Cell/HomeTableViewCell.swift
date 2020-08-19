//
//  HomeTableViewCell.swift
//  Baitap3+4
//
//  Created by ADMIN on 8/12/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleVideoLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    func bind(_ viewModel: HomeCellViewModel) {
        titleVideoLabel.text = viewModel.titleVideo
        channelTitleLabel.text = viewModel.channelTitle
        publishedAtLabel.text = viewModel.publishedAt
        thumbnailImageView.image = nil
        
        viewModel.loadImage { [weak self] image in
            guard let self = self else { return }
            self.thumbnailImageView.image = image
        }
    }
}
