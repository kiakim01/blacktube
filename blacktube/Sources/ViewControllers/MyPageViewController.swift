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
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserData), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
        likedVideosCollectionView.delegate = self
        likedVideosCollectionView.dataSource = self
//        inputDummyToUserDefaults() // 0. UserDefaults에 더미 넣기(테스트용)
        loadDataFromUserDefaults() // 1. UserDefaults에서 불러오기(테스트용)
        configureUI()
       
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
        
        if let imageData = loginUser.profileImage {
            userImage.image = UIImage(data: imageData)
        }
        userNameLabel.text = loginUser.userName
        userEmailLabel.text = loginUser.userEmail
    }
    
    @objc private func refreshUserData(notification: NSNotification){
        likedVideosCollectionView.reloadData()
        configureUI()
    }
    
    // MARK: 테스트용 코드 (시작) =========================================================================
    
    // 0. UserDefaults에 더미 넣기
    private func inputDummyToUserDefaults() {
        
        // userData
        let user1 = User(Id: "jakelee1234", password: "password1", profileImage: nil, userName: "User1", userEmail: "user1@example.com", likedVideos: nil)
        let user2 = User(Id: "liamkim3335", password: "password2", profileImage: nil, userName: "User2", userEmail: "user2@example.com", likedVideos: nil)
        let user3 = User(Id: "benpark3311", password: "password3", profileImage: nil, userName: "User3", userEmail: "user3@example.com", likedVideos: nil)

        userData.append(user1)
        userData.append(user2)
        userData.append(user3)
        
        // loginUser
        loginUser = User(Id: "jakelee1234", password: "password1", profileImage: nil, userName: "User1", userEmail: "user1@example.com", likedVideos: nil)
        
        let encoder = JSONEncoder()
        if let encodedUserData = try? encoder.encode(userData) {
            UserDefaults.standard.set(encodedUserData, forKey: "userData")
        }
        if let encodedLoginUser = try? encoder.encode(loginUser) {
            UserDefaults.standard.set(encodedLoginUser, forKey: "loginUser")
        }
    }

    // 1. UserDefaults에서 불러오기
    private func loadDataFromUserDefaults () {
        if let savedUserData = UserDefaults.standard.object(forKey: "userData") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([User].self, from: savedUserData) {
                userData = savedObject
            }
            
        }
        
        if let savedLoginUser = UserDefaults.standard.object(forKey: "loginUser") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(User.self, from: savedLoginUser) {
                loginUser = savedObject
            }
        }
    }
    // MARK: 테스트용 코드 (끝) =========================================================================

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


