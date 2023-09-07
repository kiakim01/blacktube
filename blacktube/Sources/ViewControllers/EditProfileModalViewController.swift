//
//  EditProfileModalViewController.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/06.
//

import UIKit

class EditProfileModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userEmailTextField: UITextField!
    
    @IBOutlet var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    private let imagePicker: UIImagePickerController! = UIImagePickerController()
    private var tempProfileImage: Data?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        imageTapped()
    }

    // MARK: - Methods
    private func configureUI() {
        userImage.backgroundColor = .lightGray
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
        if let imageData = loginUser.profileImage {
            userImage.image = UIImage(data: imageData)
        }
        userNameTextField.text = loginUser.userName
        userEmailTextField.text = loginUser.userEmail

    }
    
    private func imageTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        userImage.addGestureRecognizer(tapGesture)
        userImage.isUserInteractionEnabled = true
    }

    @objc private func profileImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
                tempProfileImage = imageData
                userImage.image = selectedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
        
        // 1. 편집한 유저 데이터(tempLoginUser)를 loginUser 배열에 넣기
        loginUser.userName = userNameTextField.text ?? loginUser.userName
        loginUser.userEmail = userEmailTextField.text ?? loginUser.userEmail
        if tempProfileImage != nil {
            loginUser.profileImage = tempProfileImage
        }
        
        // 2. 업데이트 된 loginUser를 UserDefaults에 저장
        let encoder = JSONEncoder()
        if let encodedLoginUser = try? encoder.encode(loginUser) {
            UserDefaults.standard.setValue(encodedLoginUser, forKey: "loginUser")
        }
        
        // 3. userData에서 loginUser를 찾아 동일한 사용자값에 씌우기
        if let index = userData.firstIndex(where: { $0.Id == loginUser.Id }) {
            userData[index].userName = loginUser.userName
            userData[index].userEmail = loginUser.userEmail
            userData[index].profileImage = loginUser.profileImage
        }
    
        // 4. 업데이트 된 userData를 UserDefaults에 저장
        if let encodedToDoTasks = try? encoder.encode(userData) {
            UserDefaults.standard.setValue(encodedToDoTasks, forKey: "userData")
        }
        
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

