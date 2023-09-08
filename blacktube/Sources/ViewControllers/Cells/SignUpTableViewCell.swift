//
//  SingUpTableViewCell.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit



class  SignUpCustomCell : UITableViewCell{
    
    //MARK: property
    
    var condition = ""
    var passHandler:((Bool)->Void)?
    var inputValueHandler:((String)->Void)?
    
    
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func layoutSubviews() {
       super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Methode
extension SignUpCustomCell {
    
    
    @objc func textFieldCheck() {
        let inputValue = userInput.text
        let pass = isValid(str: inputValue  ?? "", condition: condition)
        if pass {
            checkIcon.isHidden = false
            inputValueHandler?(inputValue ?? "")
            
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


