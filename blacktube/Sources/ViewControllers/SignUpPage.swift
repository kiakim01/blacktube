//
//  SingUpPage.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit

class SignUpPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct SignUpList {
        let title: String
        let placeHolder: String
    }
    
    let data:[SignUpList] = [
       SignUpList(title: "ID", placeHolder: "ID를 입력해주세요"),
       SignUpList(title: "비밀번호", placeHolder: "비밀번호를 입력해주세요"),
       SignUpList(title: "확인", placeHolder: "비밀번호를 다시 입력해주세요")
    ]
    
    let InfoLabel : UILabel = {
        let label = UILabel()
        label.text = "정보를 입력해주세요"
        //        label.backgroundColor = UIColor.red
        return label
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
    
    
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입하기", for: .normal)
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

extension SignUpPage{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpCustomCell", for:indexPath)
            as! SignUpCustomCell
        
        let signUpList = data[indexPath.row]
        cell.titleLabel.text = signUpList.title
        cell.userInput.placeholder = signUpList.placeHolder
        
        return cell
    }
}


extension SignUpPage{
    func configureUI(){
        self.view.addSubview(InfoLabel)
        self.view.addSubview(UserInfoArea)
        UserInfoArea.addSubview(UserInfotableView)
        UserInfotableView.delegate = self
        UserInfotableView.dataSource = self
        
        self.view.addSubview(signUpButton)
        
    }
    
    func setLayout(){
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([InfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     InfoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
                                    ])
        
        UserInfoArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([UserInfoArea.topAnchor.constraint(equalTo: InfoLabel.bottomAnchor,constant: 20),
                                     UserInfoArea.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
                                     UserInfoArea.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
                                     UserInfoArea.bottomAnchor.constraint(equalTo: signUpButton.topAnchor,constant: -20)
    
                                    ])
        UserInfotableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            UserInfotableView.topAnchor.constraint(equalTo: UserInfoArea.topAnchor),
            UserInfotableView.bottomAnchor.constraint(equalTo: UserInfoArea.bottomAnchor),
            UserInfotableView.leftAnchor.constraint(equalTo: UserInfoArea.leftAnchor),
            UserInfotableView.rightAnchor.constraint(equalTo: UserInfoArea.rightAnchor)
            
        ])
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
                                     signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
                                     signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
                                     signUpButton.heightAnchor.constraint(equalToConstant: 80)
                                    ])
      

    }
}
