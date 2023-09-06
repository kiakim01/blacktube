//
//  MainTableViewCell.swift
//  blacktube
//
//  Created by 조규연 on 2023/09/04.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        
        let index = sender.tag
        let video = videos[index]
        
        if !likedVideos.contains(video) {
            likedVideos.append(video)
        }
        else {
            for i in 0..<likedVideos.count {
                if likedVideos[i] == video {
                    likedVideos.remove(at: i)
                    break
                }
            }
        }
        
        videos[index].isLiked.toggle()
        
        if videos[index].isLiked {
            let filledHeart = UIImage(systemName: "heart.fill")?.imageWithColor(color: UIColor.red)
            sender.setImage(filledHeart, for: .normal)
        } else {
            let heart = UIImage(systemName: "heart")?.imageWithColor(color: UIColor.gray)
            sender.setImage(heart, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UIImage {
    // 버튼 전체가 아니라 버튼 이미지의 색상만 바꾸는 함수
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
