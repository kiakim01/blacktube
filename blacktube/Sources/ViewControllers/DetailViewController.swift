//
//  DetailViewController.swift
//  blacktube
//
//  Created by t2023-m079 on 2023/09/05.
//

import UIKit
import WebKit

// 일반적인 배열 이용 : Video 구조체가 Equatable 프로토콜 채택해야함. 삭제로직 귀찮


// Dictionary ["video id" : video]로 배열 선언 : tableView Cell 생성과정에서 indexPath를 NSIndexPath로 캐스팅 해주어야함.
//var likedVideos: [String:Video] = [:]

class DetailViewController: UIViewController {
    var video: Video?
    @IBOutlet weak var videoView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var videoDescription: UITextView!
    @IBOutlet weak var videoDate: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func ViewMore(_ sender: Any) {
        viewMoreButton.isHidden = true
        tagLabel.numberOfLines = 0
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoID = video?.videoId
        SetupUI()
        LoadVideo(videoID!)
    }
    
    // 영상의 타이틀, 채널명, 조회수, 설명란을 로드하는 함수
    func SetupUI () {
        
        let viewCount = video?.viewCount
        let tags = video?.tags
        var publishedDate = video?.publishedDate
        let startIndex = publishedDate!.index(publishedDate!.startIndex, offsetBy: 0)
        let endIndex = publishedDate!.index(publishedDate!.startIndex, offsetBy: 9)
        publishedDate = String(publishedDate![startIndex...endIndex])
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let viewCountInt = Int(viewCount!){
            if let formattedViewCount = formatter.string(from: NSNumber(value:viewCountInt)) {
                viewCountLabel.text = "\(formattedViewCount) views"
            }
        }
        
        titleLabel.text = video?.title
        channelLabel.text = (video?.channelTitle)! + "  ·"
        var tagText = ""
        if tags != nil {
            for tag in tags! {
                tagText += "#\(tag) "
            }
        }
        else {
            viewMoreButton.isHidden = true
        }
        

        tagLabel.text = tagText
        videoDate.text = "Uploaded at " + publishedDate!
        videoDescription.text = video?.description
        likeButton.tintColor = .red
        
        // 일반배열
        if loginUser.likedVideos.contains(video!) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        // 딕셔너리배열
//        if likedVideos[video?.item["id"] as! String] != nil{
//            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
        likeButton.addTarget(self, action: #selector(ClickButton), for: .touchUpInside)
        
    }
    
    @objc func ClickButton (_ sender: UIButton) {
        // 일반배열
        if !loginUser.likedVideos.contains(video!) {
            loginUser.likedVideos.append(video!)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("추가:  현재 좋아요 한 비디오갯수는 \(loginUser.likedVideos.count)")
        }
        else {
            for i in 0..<loginUser.likedVideos.count {
                if loginUser.likedVideos[i] == video {
                    print("\(i+1)번째 비디오 삭제")
                    loginUser.likedVideos.remove(at: i)
                    break
                }
            }
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        if let index = userData.firstIndex(where: { $0.Id == loginUser.Id }) {
            userData[index].likedVideos = loginUser.likedVideos
        }
        UserManager.shared.SaveLoginUser()
        UserManager.shared.SaveUserData()
        
        // 딕셔너리배열
//        if likedVideos[video?.item["id"] as! String] == nil {
//            likedVideos[video?.item["id"] as! String] = video!
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        else {
//            likedVideos.removeValue(forKey: video?.item["id"] as! String)
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//            print("\(video!.title) 삭제")
//        }
//        print("좋아요한 비디오 \(likedVideos.count)개")
    }
    
    // WKWebView에 영상의 id를 이용하여 유튜브에서 영상을 로드하는 함수
    func LoadVideo (_ id: String) {
        let myURL = URL(string: "https://www.youtube.com/embed/\(id)")
        let youtubeRequest = URLRequest(url: myURL!)
        videoView.load(youtubeRequest)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
