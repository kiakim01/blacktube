//
//  ViewController.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchYoutubeData()
    }
    
    func fetchYoutubeData() {
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2Cstatistics&chart=mostPopular&maxResults=25&key=AIzaSyD0zgyg0KvAu75CFl-kHfLNt8Mz_mCblx0") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let items = json["items"] as? [[String: Any]] else {
                return
            }
            
            // API에서 받아온 데이터를 파싱하여 Video 객체로 변환하고 배열에 저장
            for item in items {
                if let snippet = item["snippet"] as? [String: Any],
                   let statistics = item["statistics"] as? [String: Any],
                   let viewCount = statistics["viewCount"] as? String,
                   let thumbnails = snippet["thumbnails"] as? [String: Any],
                   let standardThumbnail = thumbnails["standard"] as? [String: Any],
                   let thumbnailURL = URL(string: standardThumbnail["url"] as! String),
                   let title = snippet["title"] as? String,
                   let publishedAt = snippet["publishedAt"] as? String {
                    
                    let video = Video(
                        title: title,
                        thumbnailURL: thumbnailURL,
                        publishedAt: publishedAt,
                        viewCount: viewCount
                    )
                    self.videos.append(video)
                }
            }
            
            // UI 업데이트는 메인 스레드에서 수행해야 함
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        
        let video = videos[indexPath.row]
        
        cell.titleLabel.text = video.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let publishedAt = dateFormatter.date(from: video.publishedAt) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: publishedAt)
            
            cell.publishLabel.text = formattedDate
        } else {
            cell.publishLabel.text = video.publishedAt
        }
        
        if let viewCountInt = Int(video.viewCount) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let formattedViewCount = formatter.string(from: NSNumber(value:viewCountInt)) {
                cell.viewCountLabel.text = "\(formattedViewCount) views"
            }
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: video.thumbnailURL) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.thumbnailView.image = image
                }
            }
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedVideo = videos[indexPath.row]
//
//        performSegue(withIdentifier: "", sender: selectedVideo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "" {
//            if let exampleVC = segue.destination as? ExampleViewController {
//                if let selectedVideo = sender as? Video {
//                    exampleVC.selectedVido = selectedVideo
//                }
//            }
//        }
    }
}
