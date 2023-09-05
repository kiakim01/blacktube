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
    @IBOutlet var logOutButton: UIButton!
    
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
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikedVideosCollectionViewCell", for: indexPath)
            return cell
    }
    
    
}

extension MyPageViewController: UICollectionViewDelegate {
    
}
