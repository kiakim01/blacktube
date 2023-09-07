//
//  EditProfileModalViewController.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/06.
//

import UIKit

class EditProfileModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userEmailTextField: UITextField!
    
    @IBOutlet var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    var flagImageSave = false // 사진저장여부
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        imageTapped()
    }

    // MARK: - Methods
    private func configureUI() {
        profileImage.backgroundColor = .lightGray
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
//        userNameTextField.text = userData.userName
//        userEmailTextField.text = userData.userEmail
        
        
    }
    
    private func loadDataFromUserDefaults () {
//        if let savedData = UserDefaults.standard.object(forKey: "userData") as? Data {
//            let decoder = JSONDecoder()
//            if let savedObject = try? decoder.decode(User.self, from: savedData) {
//                userData = savedObject
//            }
//        }
    }
    
    private func imageTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true // 이미지 뷰 상호 작용하도록
    }

    @objc private func profileImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // 이미지 선택이 완료된 후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
//                userData.profileImage = imageData
                profileImage.image = selectedImage // 선택한 이미지로 프로필 이미지 업데이트
                flagImageSave = true
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
//        let userData = User(
//            profileImage: userData.profileImage, // TODO: 고치기
//            userName: userNameTextField.text ?? "", // TODO: 고치기
//            userEmail: userEmailTextField.text ?? "" // TODO: 고치기
//        )

        let encoder = JSONEncoder()
        if let encodedToDoTasks = try? encoder.encode(userData) {
            UserDefaults.standard.setValue(encodedToDoTasks, forKey: "userData")
        }
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}





// UserDefaults에 이미지 저장할때 예시
//func saveImage() {
//    guard let data = UIImage(named: "image").jpegData(compressionQuality: 0.5) else { return }
//    let encoded = try! PropertyListEncoder().encode(data)
//    UserDefaults.standard.set(encoded, forKey: "KEY")
//}
//
//func loadImage() {
//     guard let data = UserDefaults.standard.data(forKey: "KEY") else { return }
//     let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
//     let image = UIImage(data: decoded)
//}


