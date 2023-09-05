//
//  LikePageViewController.swift
//  blacktube
//
//  Created by Jongbum Lee on 2023/09/04.
//

import UIKit
import AVFoundation

class LikePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var videos = dummyVideos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? CustomVideoCell else {
            return UITableViewCell()
        }
        
        let video = videos[indexPath.row]
        cell.titleLabel.text = video.title
        cell.channelLabel.text = video.channelTitle

        URLSession.shared.dataTask(with: video.thumbnailURL) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = image
                }
            }
        }.resume()

        URLSession.shared.dataTask(with: video.channelIconURL) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.channelIconImageView.image = image
                }
            }
        }.resume()

        return cell
    }
    
    let dummyVideos: [Video] = [
        Video(
            title: "Sample Video 1",
            thumbnailURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!,
            viewCount: "1M",
            channelTitle: "Channel A",
            channelIconURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!
        ),
        Video(
            title: "Sample Video 2",
            thumbnailURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!,
            viewCount: "2M",
            channelTitle: "Channel B",
            channelIconURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!
        ),
    ]
}

class CustomVideoCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelIconImageView: UIImageView!
    
}

struct Video {
    let title: String
    let thumbnailURL: URL
    let viewCount: String
    let channelTitle: String
    let channelIconURL: URL
}

