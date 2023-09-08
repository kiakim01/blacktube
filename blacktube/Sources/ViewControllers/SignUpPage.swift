//
//  SingUpPage.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit


class SignUpPage:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct SignUpList {
        let id : Int
        let title: String
        let placeHolder: String
        let condition: String
        var pass : Bool
        var inputValue : String
        let isSecure : Bool
    }
    
    var data:[SignUpList] = [
        SignUpList(id:0, title: "ID", placeHolder: "ID를 입력해주세요", condition: "^[a-zA-Z0-9]{3,}$",pass: false, inputValue:"", isSecure: false),
        SignUpList(id:1,title: "Password", placeHolder: "비밀번호를 입력해주세요", condition:"^[a-zA-Z0-9]{5,}$",pass: false, inputValue:"", isSecure: true),
        SignUpList(id:2,title: "Password check", placeHolder: "비밀번호를 다시 입력해주세요", condition: "^[a-zA-Z0-9]{5,}$",pass: false ,inputValue:"", isSecure: true),
        SignUpList(id:3,title: "Name", placeHolder: "이름을 입력해주   세요", condition: "^[a-zA-Z0-9]{5,}$",pass: false, inputValue:"", isSecure: false ),
        SignUpList(id:4,title: "E-mail", placeHolder: "이메일을 입력해주세요", condition: "^[a-zA-Z0-9_+.-]+@[a-zA-Z0-9.-]+$",pass: false ,inputValue:"", isSecure: false)
    ]
    
    let InfoLabel : UILabel = {
        let label = UILabel()
        label.text = "정보를 입력해주세요"
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

//MARK: Method
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
        
       
        cell.passHandler = {[weak self] pass in
            self?.data[indexPath.row].pass = pass
            
        }
        //클로져[3] 본문
        cell.inputValueHandler = {[weak self] inputValueCell in self?.data[indexPath.row].inputValue = inputValueCell
        }
        
        cell.userInput.tag = indexPath.row
        cell.checkIcon.isHidden = true
        cell.condition = signUpList.condition
        

        
        if signUpList.isSecure {
            cell.userInput.isSecureTextEntry = true
        }
        
//        sum(left: 1, right: 2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @objc func submitInput(_ sender:UITextField){
        let allPass = data.allSatisfy { item in
            return item.pass
        }
        
        if allPass {
            let id = data[0].inputValue
            let pw = data[1].inputValue
            let name = data[3].inputValue
            let email = data[4].inputValue
            
            //userData 저장
            let addUserData = User (Id: id, password: pw, userName: name, userEmail: email)
            userData.append(addUserData)
            //useDefalut 저장
            UserDefaults.standard.set(try? JSONEncoder().encode(userData), forKey: addUserData.Id)

            //navigation
            let loginPage = LoginPage()
            self.present(loginPage, animated: true)
            
        }
        else {
            let alert = UIAlertController(title: "확인해주세요", message: "입력되지 않은 정보가 있습니다.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .cancel){(cancle)in}
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func isValid(str:String, condition:String) -> Bool {
        let RegEx = condition
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: str)
    }
}

//MARK: UI
extension SignUpPage{
    
    func configureUI(){
        //다크모드 고려필요
        view.backgroundColor = UIColor.white
        self.view.addSubview(InfoLabel)
        self.view.addSubview(UserInfoArea)
        UserInfoArea.addSubview(UserInfotableView)
        UserInfotableView.delegate = self
        UserInfotableView.dataSource = self
        UserInfotableView.separatorStyle = .none
        self.view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(submitInput), for: .touchUpInside)
        
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
            UserInfotableView.topAnchor.constraint(equalTo: UserInfoArea.topAnchor,constant: 30),
            UserInfotableView.bottomAnchor.constraint(equalTo: UserInfoArea.bottomAnchor),
            UserInfotableView.leftAnchor.constraint(equalTo: UserInfoArea.leftAnchor),
            UserInfotableView.rightAnchor.constraint(equalTo: UserInfoArea.rightAnchor)
            
        ])
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
                                     signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
                                     signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
                                     signUpButton.heightAnchor.constraint(equalToConstant: 70)
                                    ])
    }
    
}
