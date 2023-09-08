//
//  SingUpTableViewCell.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit



class  SignUpCustomCell : UITableViewCell{
    //bring VC data
    var condition = ""
    
    //클로져!!!
    var passHandler:((Bool)->Void)?
    
    //MARK: property
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.widthAnchor.constraint(equalToConstant: 90).isActive = true
        return label
    }()
    
    let userInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.autocapitalizationType = .none
        
        
        let placeholderPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = placeholderPadding
        textField.leftViewMode = .always
        textField.frame.size.width = 180
        textField.frame.size.height = 35
        textField.layer.addBorder([.bottom], color: UIColor.gray, width: 0.5)
        return textField
    }()
    
    let checkIcon : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.circle")
        return view
    }()
    
    
    //customCell을 만들때 작성하는 형식으로, 초기화 과정을 다루고 있음
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        //셀의 스타일과, 재사용 식별자를 매개변수로 받고 있음.
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    
    
    required init?(coder: NSCoder) {
        //1번: 스토리보드에서 셀을 초기화 하지 않도록 강제(스토리보드를 사용하지 않았음으로 1번 코드 채택)
        fatalError("init(coder:) has not been implemented")
        //2번 :super.init을 호출해서 셀을 초기화 할수있도록 함.
        //        super.init(coder: coder)
    }
}

//MARK: Methode
extension SignUpCustomCell {
    
    
    @objc func textFieldCheck() {
        let userIput = userInput.text
        let pass = isValid(str: userIput  ?? "", condition: condition)
        if pass {
            checkIcon.isHidden = false
        }
        passHandler?(pass)
    }
    
    func isValid(str:String, condition:String) -> Bool {
        let emailRegEx = condition
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: str)
    }
    
}


//MARK: UI
extension SignUpCustomCell {
    func configureUI(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(userInput)
        contentView.addSubview(checkIcon)
        userInput.addTarget(self, action: #selector(textFieldCheck), for: .editingChanged)
        
    }
    func setLayout(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 30),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        userInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInput.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5),
            userInput.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userInput.rightAnchor.constraint(equalTo: checkIcon.leftAnchor,constant: -10)
        ])
        
        checkIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -30),
            checkIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
}


