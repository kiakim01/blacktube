//
//  MyPageViewController.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/05.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Properties


    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var logOutButton: UIButton!

    @IBOutlet var likedVideosCollectionView: UICollectionView!
    
    @IBOutlet var switchDarkMode: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserData), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
        likedVideosCollectionView.delegate = self
        likedVideosCollectionView.dataSource = self
        navigationBar.delegate = self
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
//        setAppLogoToNavigationBar()
    }
    
//    func setAppLogoToNavigationBar() {
//
//        let logoImageView = UIImageView(image: UIImage(named: "blacktube_applogo_black"))
//        logoImageView.frame = CGRect(x: 20, y: 5, width: 40, height: 27)
//        navigationBar.addSubview(logoImageView)
//    }

    @objc private func refreshUserData(notification: NSNotification){
        likedVideosCollectionView.reloadData()
        configureUI()
    }
    
    @objc private func showEditProfileModal() {
        
        let editProfileModalVC = UIStoryboard(name: "EditProfilePage", bundle: nil).instantiateViewController(withIdentifier: "EditProfileModalViewController") as! EditProfileModalViewController
        editProfileModalVC.modalPresentationStyle = .pageSheet

        if let presentationController = editProfileModalVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        self.present(editProfileModalVC, animated: true, completion: nil)
    }
    
    @IBAction func switchDarkMode(_ sender: Any) {
        if self.traitCollection.userInterfaceStyle == .dark {
            if let image = UIImage(systemName: "moon") {
                let symbol = image.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
                switchDarkMode.setImage(symbol, for: .normal)
            }
            self.view.window?.overrideUserInterfaceStyle = .light
        } else {
            if let image = UIImage(systemName: "moon.fill") {
                let symbol = image.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
                switchDarkMode.setImage(symbol, for: .normal)
            }
            self.view.window?.overrideUserInterfaceStyle = .dark
        }
        loginUser.isDarkMode.toggle()
        if let index = userData.firstIndex(where: { $0.Id == loginUser.Id }) {
            userData[index].isDarkMode = loginUser.isDarkMode
        }
        UserManager.shared.SaveLoginUser()
        UserManager.shared.SaveUserData()
    }
    @IBAction func moveToEditProfileModal(_ sender: Any) {
        showEditProfileModal()
    }
    
    @IBAction func logoutButtonClick(_ sender: Any) {
        loginUser = guest
        UserManager.shared.SaveLoginUser()
        let newStoryboard = UIStoryboard(name: "LoginPage", bundle: nil)
        let newViewController = newStoryboard.instantiateViewController(identifier: "LoginPage")
        self.changeRootViewController(newViewController)
    }
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    
    // MARK: 테스트용 코드 (시작) =========================================================================
    
    // 0. UserDefaults에 더미 넣기
//    private func inputDummyToUserDefaults() {
//
//        // userData
//        let user1 = User(Id: "jakelee1234", password: "password1", profileImage: nil, userName: "User1", userEmail: "user1@example.com", likedVideos: nil)
//        let user2 = User(Id: "liamkim3335", password: "password2", profileImage: nil, userName: "User2", userEmail: "user2@example.com", likedVideos: nil)
//        let user3 = User(Id: "benpark3311", password: "password3", profileImage: nil, userName: "User3", userEmail: "user3@example.com", likedVideos: nil)
//
//        userData.append(user1)
//        userData.append(user2)
//        userData.append(user3)
//
//        // loginUser
//        loginUser = User(Id: "jakelee1234", password: "password1", profileImage: nil, userName: "User1", userEmail: "user1@example.com", likedVideos: nil)
//
//        let encoder = JSONEncoder()
//        if let encodedUserData = try? encoder.encode(userData) {
//            UserDefaults.standard.set(encodedUserData, forKey: "userData")
//        }
//        if let encodedLoginUser = try? encoder.encode(loginUser) {
//            UserDefaults.standard.set(encodedLoginUser, forKey: "loginUser")
//        }
//    }

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
        if loginUser.likedVideos.count == 0 {
            return 1
        } else {
            return loginUser.likedVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikedVideosCollectionViewCell", for: indexPath) as! LikedVideosCollectionViewCell
        cell.layer.cornerRadius = 10
        
        if loginUser.likedVideos.count == 0 {
            cell.thumbnailImage.isHidden = true
            cell.titleLabel.isHidden = true
            cell.channelLabel.isHidden = true
            cell.viewCountLabel.isHidden = true
            cell.plusButton.isHidden = false
            cell.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        } else {
            cell.thumbnailImage.isHidden = false
            cell.titleLabel.isHidden = false
            cell.channelLabel.isHidden = false
            cell.viewCountLabel.isHidden = false
            cell.plusButton.isHidden = true
            cell.backgroundColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1.00)
            
            let video = loginUser.likedVideos[indexPath.item]
            cell.configure(video)
        }
//        likedVideosCollectionView.reloadData()
        return cell
        
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "likedVideoCell", loginUser.likedVideos.count == 0 {
            return false // segue를 막음
        }
        return true // segue를 실행
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if loginUser.likedVideos.count != 0, segue.identifier == "likedVideoCell", let detailVC = segue.destination as? DetailViewController, let selectedIndexPath = likedVideosCollectionView.indexPathsForSelectedItems?.first {
            detailVC.video = loginUser.likedVideos[selectedIndexPath.item]
        }
    }
}

extension MyPageViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


