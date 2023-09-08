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
    @IBOutlet var plusButton: UILabel!
    
    // MARK: - Methods
    
    func configure(_ video: Video) {
    
        URLSession.shared.dataTask(with: video.thumbnailURL) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.thumbnailImage.image = image
                }
            }
        }.resume()

        titleLabel.text = video.title
        channelLabel.text = video.channelTitle
        viewCountLabel.text = "\(video.viewCount) views"
    }
    
}


