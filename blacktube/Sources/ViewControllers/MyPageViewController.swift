//
//  MyPageViewController.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/05.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    
    var likedVideos: [Video2] = [
        Video2(
            title: "Sample Video 1",
            thumbnailURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!,
            viewCount: "1M",
            channelTitle: "Channel A",
            channelIconURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!
        ),
        Video2(
            title: "Sample Video 2",
            thumbnailURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!,
            viewCount: "2M",
            channelTitle: "Channel B",
            channelIconURL: URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!
        ),
    ]
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var logOutButton: UIButton!
    
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var likedVideosCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        likedVideosCollectionView.delegate = self
        likedVideosCollectionView.dataSource = self
    }
    // MARK: - UI
    func configureUI() {
        userImage.backgroundColor = .lightGray
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
    }

}

// MARK: - Collection View
extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedVideos.count
//        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikedVideosCollectionViewCell", for: indexPath) as! LikedVideosCollectionViewCell
        cell.layer.cornerRadius = 10
        
        // indexPath를 사용하여 해당 셀에 표시할 데이터를 가져옴
        let video = likedVideos[indexPath.row]
            
        // 셀에 데이터를 설정
        cell.configure(video)
        
        return cell
    }
    
    
}

extension MyPageViewController: UICollectionViewDelegate {
    
}
