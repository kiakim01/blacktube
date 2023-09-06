//
//  MyPageViewController.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/05.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    
    
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var logOutButton: UIButton!
    
 
    @IBOutlet var likedVideosCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        likedVideosCollectionView.delegate = self
        likedVideosCollectionView.dataSource = self
        
        print("likedVideos 수 : ",likedVideos.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        likedVideosCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedVideo = likedVideos[indexPath.item] // selectedVideo : 선택한 셀의 데이터
        print("22 : ", selectedVideo)
        performSegue(withIdentifier: "likedVideoCell", sender: selectedVideo) // Segue실행, 화면전환
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likedVideoCell" {
            if let detailVC = segue.destination as? DetailViewController {
                if let selectedVideo = sender as? Video {
                    detailVC.video = selectedVideo // 선택한 비디오 데이터를 detailViewController에 전달
                }
            }
        }
    }
}
