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
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikedVideosCollectionViewCell", for: indexPath) as! LikedVideosCollectionViewCell
        cell.layer.cornerRadius = 10
        
        let video = likedVideos[indexPath.item]
        cell.configure(video)
        
        
        return cell
    }
}


extension MyPageViewController: UICollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likedVideoCell", let detailVC = segue.destination as? DetailViewController, let selectedIndexPath = likedVideosCollectionView.indexPathsForSelectedItems?.first {
            detailVC.video = likedVideos[selectedIndexPath.item]
        }
    }
}


