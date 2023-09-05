//
//  LikedVideosCollectionViewCell.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/05.
//

import UIKit

class LikedVideosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var channelLabel: UILabel!
    @IBOutlet var viewCountLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(_ video: Video) {
    
        titleLabel.text = video.title
        channelLabel.text = video.channelTitle
        viewCountLabel.text = "\(video.viewCount) views"
    }
   
}


