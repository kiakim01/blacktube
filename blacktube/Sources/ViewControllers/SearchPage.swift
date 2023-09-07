//
//  SearchPage.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit

class SearchPage: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    var searchVideos: [Video] = []
    
    let searchBox : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.backgroundColor = UIColor.red
//        stackView.layer.borderColor = UIColor.gray.cgColor
//        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 20
        stackView.frame.size.width = 370
        stackView.frame.size.height = 60
        stackView.layer.addBorder([.bottom], color: UIColor(hex: "edede9"), width: 0.5)
        return stackView
    }()
    
    let searchIcon : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "magnifyingglass")
        //        icon.backgroundColor = UIColor.red
        icon.tintColor = UIColor.gray
        return icon
    }()
    
    let searchTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "BlackTube 검색"
        textField.backgroundColor = UIColor(hex: "edede9")
        textField.layer.cornerRadius = 10
        
        let placeholderPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = placeholderPadding
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(SearchItem), for: .editingChanged)
        
        return textField
    }()
    
    
    let micBox : UIView = {
        let micBox = UIView()
        micBox.backgroundColor = UIColor(hex: "edede9")
        micBox.layer.cornerRadius = 20
        micBox.layer.masksToBounds = true
        return micBox
    }()
    
    let micIcon : UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "mic.fill")
//        icon.backgroundColor = UIColor.red
        icon.tintColor = UIColor.black
        return icon
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
}

extension SearchPage{
    func configureUI(){
        view.addSubview(searchBox)
        searchBox.addSubview(searchIcon)
        searchBox.addSubview(micBox)
        searchBox.addSubview(searchTextField)
        micBox.addSubview(micIcon)
    }
    func setLayout(){
        searchBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBox.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            searchBox.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            searchBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            searchBox.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchIcon.leftAnchor.constraint(equalTo: searchBox.leftAnchor,constant: 10),
            searchIcon.centerYAnchor.constraint(equalTo: searchBox.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 30),
            searchIcon.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.leftAnchor.constraint(equalTo: searchIcon.rightAnchor, constant: 10),
            searchTextField.rightAnchor.constraint(equalTo: micBox.leftAnchor,constant: -10),
            searchTextField.centerYAnchor.constraint(equalTo: searchBox.centerYAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        micBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            micBox.rightAnchor.constraint(equalTo: searchBox.rightAnchor, constant: -10),
            micBox.centerYAnchor.constraint(equalTo: searchBox.centerYAnchor),
            micBox.widthAnchor.constraint(equalToConstant: 30),
            micBox.heightAnchor.constraint(equalToConstant: 30)
        ])
        micIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            micIcon.centerXAnchor.constraint(equalTo: micBox.centerXAnchor),
            micIcon.centerYAnchor.constraint(equalTo: micBox.centerYAnchor),
            micIcon.widthAnchor.constraint(equalToConstant: 20),
            micIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

extension SearchPage: UITableViewDelegate, UITableViewDataSource {
    
    @objc func SearchItem(_ sender:UITextField) {
        let key = sender.text ?? ""
        searchVideos = []
        for video in videos {
            if video.title.lowercased().contains(key.lowercased()) {
                searchVideos.append(video)
            }
        }
        self.searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let video = searchVideos[indexPath.row]
        
        cell.titleLabel.text = video.title
        
        if let viewCountInt = Int(video.viewCount) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let formattedViewCount = formatter.string(from: NSNumber(value:viewCountInt)) {
                cell.viewCountLabel.text = "\(formattedViewCount) views"
                cell.viewCountLabel.font = UIFont.systemFont(ofSize: 12,weight: .thin)
            }
        }
        
        cell.channelLabel.text = "\(video.channelTitle)  ·"
        cell.channelLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        
        cell.heartButton.isSelected = false
        cell.heartButton.tintColor = .clear
        let heart = UIImage(systemName: "heart")?.imageWithColor(color: UIColor.gray)
        cell.heartButton.setImage(heart, for: .normal)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: video.thumbnailURL) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.thumbnailView.image = image
                }
            }
        }
        return cell
    }
    
    
}
