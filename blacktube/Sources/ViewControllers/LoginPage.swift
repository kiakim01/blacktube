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
    }
    
    let data:[LoginList] = [
        LoginList(title: "ID", placeHolder: "ID를 입력해주세요"),
        LoginList(title: "Password", placeHolder: "비밀번호를 입력해주세요")
       
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpCustomCell", for:indexPath)
            as! SignUpCustomCell
        
        let LoginList = data[indexPath.row]
        cell.titleLabel.text = LoginList.title
        cell.userInput.placeholder = LoginList.placeHolder
        cell.checkIcon.isHidden = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    
    let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        //        label.backgroundColor = UIColor.red
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
        tableView.`register`(SignUpCustomCell.self,forCellReuseIdentifier: "SignUpCustomCell")
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    

    
}



extension LoginPage{
    func configureUI(){
        self.view.addSubview(mainImage)
        self.view.addSubview(UserInfoArea)
        UserInfoArea.addSubview(UserInfotableView)
        UserInfotableView.delegate = self
        UserInfotableView.dataSource = self
        UserInfotableView.separatorStyle = .none
        self.view.addSubview(LoginButton)
//        self.view.addSubview(goToSignUpButton)
      
        
        
      
    
    }
    
    func setLayout(){
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
                                     mainImage.widthAnchor.constraint(equalToConstant:200),
                                     mainImage.heightAnchor.constraint(equalToConstant: 200)
                                    ])
        
        UserInfoArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([UserInfoArea.topAnchor.constraint(equalTo: mainImage.bottomAnchor,constant: 20),
                                     UserInfoArea.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
                                     UserInfoArea.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
                                     UserInfoArea.bottomAnchor.constraint(equalTo: LoginButton.topAnchor,constant: -50)
    
                                    ])
        UserInfotableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         
   
            UserInfotableView.topAnchor.constraint(equalTo: UserInfoArea.topAnchor,constant: 40),
            UserInfotableView.bottomAnchor.constraint(equalTo: UserInfoArea.bottomAnchor),
            UserInfotableView.leftAnchor.constraint(equalTo: UserInfoArea.leftAnchor),
            UserInfotableView.rightAnchor.constraint(equalTo: UserInfoArea.rightAnchor)
            
        ])
        
//        goToSignUpButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            goToSignUpButton.topAnchor.constraint(equalTo: UserInfoArea.bottomAnchor,constant: 10),
//            goToSignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
        
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([LoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -100),
                                     LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
                                     LoginButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
                                     LoginButton.heightAnchor.constraint(equalToConstant: 70)
                                    ])
      

    }
}
