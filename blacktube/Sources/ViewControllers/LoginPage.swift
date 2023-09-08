//
//  LoginPage.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit

class LoginPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct LoginList {
        let title: String
        let placeHolder: String
        let isSecure : Bool
    }
    
    var inputID: String = ""
    var inputPW: String = ""
    
    let data:[LoginList] = [
        LoginList(title: "ID", placeHolder: "ID를 입력해주세요",isSecure: false),
        LoginList(title: "Password", placeHolder: "비밀번호를 입력해주세요",isSecure: true)
       
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell", for:indexPath)
            as! LoginTableViewCell
        
        let loginList = data[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = loginList.title
        cell.userInput.placeholder = loginList.placeHolder
        if indexPath.row == 1 {
            cell.userInput.isSecureTextEntry = true
        }
        cell.userInput.autocapitalizationType = .none
        cell.userInput.tag = indexPath.row
        cell.userInput.addTarget(self, action: #selector(ChangeID), for: .editingChanged)
        cell.checkIcon.isHidden = true
        
        if loginList.isSecure {
            cell.userInput.isSecureTextEntry = true
        }
        
        
        return cell
    }
    
    @objc func ChangeID (_ sender: UITextField) {
        if sender.tag == 0 {
            inputID = sender.text ?? ""
        }
        else if sender.tag == 1 {
            inputPW = sender.text ?? ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    
    let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blacktube_applogo_black")
        return image
    }()
    
    
    let UserInfoArea : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    let UserInfotableView : UITableView = {
        let tableView = UITableView()
        tableView.`register`(LoginTableViewCell.self,forCellReuseIdentifier: "LoginTableViewCell")
        
        return tableView
    }()
    
    
    let goToSignUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
     
      return button
    }()
    
    let LoginButton : UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 20
        return button
    }()
    
    //navigation
    @objc func signUpButtonClick(){
            let signUpPageVC = SignUpPage()
        self.navigationController?.pushViewController(signUpPageVC, animated: true)
//        self.present(signUpPageVC, animated: true)
    }
    
    @objc func LoginButtonClick (_ sender: UIButton) {
        var index: Int?
        
        for i in 0..<userData.count {
            if userData[i].Id == inputID {
                index = i
            }
        }
        
        if index == nil {
            ShowAlert("존재하지 않는 ID입니다.")
        }
        else {
            if userData[index!].password == inputPW {
                ShowAlert("\(userData[index!].Id) 로그인 성공")
                loginUser = userData[index!]
                UserManager.shared.SaveLoginUser()
                GoToMain()
                
            }
            else {
                ShowAlert("암호가 틀렸습니다.")
            }
        }
        
        
    }
    func GoToMain() {
        let newStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = newStoryboard.instantiateViewController(identifier: "MainNavigation")
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
    
    func ShowAlert (_ text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.LoadLoginUser()
        UserManager.shared.LoadUserData()
        if loginUser != guest {
            GoToMain()
        }
        print(loginUser)
        configureUI()
        setLayout()
    }
    

    
}



extension LoginPage{
    func configureUI(){
        view.backgroundColor = UIColor.white
        self.view.addSubview(mainImage)
        self.view.addSubview(UserInfoArea)
        UserInfoArea.addSubview(UserInfotableView)
        UserInfotableView.delegate = self
        UserInfotableView.dataSource = self
        UserInfotableView.separatorStyle = .none
        self.view.addSubview(LoginButton)
        self.view.addSubview(goToSignUpButton)
        goToSignUpButton.addTarget(self, action: #selector(signUpButtonClick), for: .touchUpInside)
        LoginButton.addTarget(self, action: #selector(LoginButtonClick), for: .touchUpInside)
      
    
    }
    
    func setLayout(){
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
                                     mainImage.widthAnchor.constraint(equalToConstant:150),
                                     mainImage.heightAnchor.constraint(equalToConstant: 100)
                                    ])
        
        UserInfoArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([UserInfoArea.heightAnchor.constraint(equalToConstant: 240),
                                     UserInfoArea.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
                                     UserInfoArea.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
                                     UserInfoArea.topAnchor.constraint(equalTo: mainImage.bottomAnchor,constant: 50),
                                    ])
        UserInfotableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         UserInfotableView.topAnchor.constraint(equalTo: UserInfoArea.topAnchor,constant: 40),
            UserInfotableView.bottomAnchor.constraint(equalTo: UserInfoArea.bottomAnchor),
            UserInfotableView.leftAnchor.constraint(equalTo: UserInfoArea.leftAnchor),
            UserInfotableView.rightAnchor.constraint(equalTo: UserInfoArea.rightAnchor)
            
        ])
        
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginButton.topAnchor.constraint(equalTo: UserInfoArea.bottomAnchor, constant: 40),
                                     LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
                                     LoginButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),LoginButton.bottomAnchor.constraint(equalTo: goToSignUpButton.topAnchor,constant: 10),
                                     LoginButton.heightAnchor.constraint(equalToConstant: 70)
                                    ])
      
        goToSignUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goToSignUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -65),
            goToSignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
}
