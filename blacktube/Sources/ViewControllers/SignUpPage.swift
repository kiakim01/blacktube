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
        let celltype : Celltype
        
    }
    
    var data:[SignUpList] = [
        SignUpList(id:0, title: "ID", placeHolder: "ID를 입력해주세요", condition: "^[a-zA-Z0-9]{5,}$",pass: false, inputValue:"", celltype: .id),
        SignUpList(id:1,title: "Password", placeHolder: "비밀번호를 입력해주세요", condition:"^[a-zA-Z0-9]{5,}$",pass: false, inputValue:"", celltype: .password),
        SignUpList(id:2,title: "Password\ncheck", placeHolder: "비밀번호를 다시 입력해주세요", condition: "^[a-zA-Z0-9]{8,16}$",pass: false ,inputValue:"", celltype: .password),
        SignUpList(id:3,title: "Name", placeHolder: "이름을 입력해주   세요", condition: "^[a-zA-Z0-9]{5,}$",pass: false, inputValue:"", celltype: .name ),
        SignUpList(id:4,title: "E-mail", placeHolder: "이메일을 입력해주세요", condition: "^[a-zA-Z0-9]{5,}$",pass: false ,inputValue:"", celltype: .email)
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
    
    func configureUI(){
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

//MARK: Method
extension SignUpPage{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpCustomCell", for:indexPath)
        as! SignUpCustomCell
        
        
        let signUpList = data[indexPath.row]
        
        //[Ho]
        // cell.celltype = signUpList.celltype
        
        cell.titleLabel.text = signUpList.title
        cell.userInput.placeholder = signUpList.placeHolder
        cell.userInput.addTarget(self, action: #selector(checkValue), for: .editingChanged)
        cell.userInput.tag = indexPath.row
        cell.checkIcon.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    @objc func checkValue(_ sender: UITextField, forCell cell:SignUpCustomCell) {
        //해당 row에 있는 cell 자체를 가져오는작업 .. !
        //let cell = UserInfotableView.cellForRow(at: IndexPath(row: sender.tag, section: 0))
        
        
        
        //[하고싶은 동작] : inputText와 condition를 비교 후 일치하면,
        // 1.cell의 UI 변경 checkIcon.isHidden = false
        // 2.data의 변경 : SignUpList.pass = true
        // 3.data의 변경 : inputValue = inputText.text
        
        //A.cell.userInput.text
        let text = sender.text
        //B.SignUpList의 데이터
        //        let condition = data[sender.tag].condition
        //C.checkIcon [조정 checkIcon]_1
        let cell = cell
        //        let icon = cell.checkIcon
        
        
        let inputValue = data[sender.tag].inputValue
        let spellCount = text?.count
        if spellCount ?? 0 >= 5 {
            data[sender.tag].inputValue = text ?? ""
            data[sender.tag].pass = true
            
            //            for item in data {
            //                          print("[ID:\(item.id)],[title:\(item.title)],[pass:\(item.pass)],[inputValue:\(item.inputValue)]")
            //                      }
            
        }else {
            //알럿 : 내용을 다시 확인해주세요
            
        }
        
    }
    
    @objc func submitInput(_ sender:UITextField){
        
        //     [하고싶은 동작] SignUpList.pass의 모든 값이 ture 일때,
        //      1. SignUpList.inputValue에 각 데이터를 저장
        //      2. UserDefaluts저장 & customCell ("SignUpList.title값 활용")
        
        
        let allPass = data.allSatisfy { item in
            return item.pass
        }

        
        if allPass {
            //useDefalut 저장
            //규연님 코드 참고
            for item in data {
                 UserDefaults.standard.set(item.inputValue, forKey: item.title)
            }
            

        
            
            
            //Check
                        let idCheck = UserDefaults.standard.string(forKey: "ID")
                        let passwordCheck = UserDefaults.standard.string(forKey: "Password")
                        let nameCheck = UserDefaults.standard.string(forKey: "Name")
                        let emailCheck = UserDefaults.standard.string(forKey: "E-mail")

                        print("저장된 id,\(idCheck)")
                        print("저장된 pw,\(passwordCheck)")
                        print("저장된 name,\(nameCheck)")
                        print("저장된 email,\(emailCheck)")
        }
        else {
            let alert = UIAlertController(title: "확인해주세요", message: "입력되지 않은 정보가 있습니다.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .cancel){(cancle)in}
            
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
        
        //[Ho]
        //        data[0].inputValue //id
        //        data[1].inputValue //password
        //        data[3].inputValue //name
        //        data[4].inputValue //email
        //
        //
        //        switch data[0].celltype {
        //
        //
        //        case .id:
        //            UserDefaults.standard.set(data[0].inputValue, forKey: "id")
        //        case .password:
        //            UserDefaults.standard.set(data[1].inputValue, forKey: "password")
        //        case .name:
        //            UserDefaults.standard.set(data[3].inputValue, forKey: "name")
        //        case .email:
        //            UserDefaults.standard.set(data[4].inputValue, forKey: "email")
        //        }
        //
        //        switch data[1].celltype {
        //            //
        //
        //        case .id:
        //            UserDefaults.standard.set(data[0].inputValue, forKey: "id")
        //        case .password:
        //            UserDefaults.standard.set(data[1].inputValue, forKey: "password")
        //        case .name:
        //            UserDefaults.standard.set(data[3].inputValue, forKey: "name")
        //        case .email:
        //            UserDefaults.standard.set(data[4].inputValue, forKey: "email")
        //        }
        //
        //        switch data[3].celltype {
        //
        //        case .id:
        //            UserDefaults.standard.set(data[0].inputValue, forKey: "id")
        //        case .password:
        //            UserDefaults.standard.set(data[1].inputValue, forKey: "password")
        //        case .name:
        //            UserDefaults.standard.set(data[3].inputValue, forKey: "name")
        //        case .email:
        //            UserDefaults.standard.set(data[4].inputValue, forKey: "email")
        //        }
        //
        //        switch data[4].celltype {
        //        case .id:
        //            UserDefaults.standard.set(data[0].inputValue, forKey: "id")
        //        case .password:
        //            UserDefaults.standard.set(data[1].inputValue, forKey: "password")
        //        case .name:
        //            UserDefaults.standard.set(data[3].inputValue, forKey: "name")
        //        case .email:
        //            UserDefaults.standard.set(data[4].inputValue, forKey: "email")
        //        }
        
        // Assuming you have populated the `userData` array with `UserData` objects
        
        
        
    }
    
    
    
    
    
}
