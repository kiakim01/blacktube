//
//  DetailViewController.swift
//  blacktube
//
//  Created by t2023-m079 on 2023/09/05.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var video: Video?
    @IBOutlet weak var videoView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var videoDescription: UITextView!
    @IBOutlet weak var videoDate: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoID = video?.item["id"] as! String
        SetupUI()
        LoadVideo(videoID)
    }
    
    // 영상의 타이틀, 채널명, 조회수, 설명란을 로드하는 함수
    func SetupUI () {
        
        let snippet = video?.item["snippet"] as! [String : Any]
        let statistics = video?.item["statistics"] as? [String: Any]
        let viewCount = statistics?["viewCount"] as? String
        var publishedDate = snippet["publishedAt"] as! String
        let startIndex = publishedDate.index(publishedDate.startIndex, offsetBy: 0)
        let endIndex = publishedDate.index(publishedDate.startIndex, offsetBy: 9)
        publishedDate = String(publishedDate[startIndex...endIndex])
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let viewCountInt = Int(viewCount!){
            if let formattedViewCount = formatter.string(from: NSNumber(value:viewCountInt)) {
                viewCountLabel.text = "\(formattedViewCount) views"
            }
        }
        
        titleLabel.text = video?.title
        channelLabel.text = (video?.channelTitle)! + "  ·"
        videoDate.text = "Uploaded at " + publishedDate
        videoDescription.text = snippet["description"] as? String
        likeButton.tintColor = .red
//        if likedVideo[video?.item["id"] as! String] != nil{
//            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
        likeButton.addTarget(self, action: #selector(ClickButton), for: .touchUpInside)
        
    }
    
    @objc func ClickButton (_ sender: UIButton) {
//        if likedVideo[video?.item["id"] as! String] == nil {
//            likedVideo[video?.item["id"] as! String] = video!
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        else {
//            likedVideo.removeValue(forKey: video?.item["id"] as! String)
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//        print(likedVideo.count)
    }
    
    // WKWebView에 영상의 id를 이용하여 유튜브에서 영상을 로드하는 함수
    func LoadVideo (_ id: String) {
        let myURL = URL(string: "https://www.youtube.com/embed/\(id)")
        let youtubeRequest = URLRequest(url: myURL!)
        videoView.load(youtubeRequest)
    }

}
