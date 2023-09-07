//
//  SearchTableViewCell.swift
//  blacktube
//
//  Created by t2023-m079 on 2023/09/07.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetupUI (_ video: Video) {
        titleLabel.text = video.title
        if let viewCountInt = Int(video.viewCount) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let formattedViewCount = formatter.string(from: NSNumber(value:viewCountInt)) {
                viewCountLabel.text = "\(formattedViewCount) views"
                viewCountLabel.font = UIFont.systemFont(ofSize: 12,weight: .thin)
            }
        }
        
        channelLabel.text = "\(video.channelTitle)  ·"
        channelLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        
        heartButton.tintColor = .gray
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        if likedVideos.contains(video) {
            heartButton.tintColor = .red
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: video.thumbnailURL) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.thumbnailView.image = image
                }
            }
        }
        
        
    }

}
