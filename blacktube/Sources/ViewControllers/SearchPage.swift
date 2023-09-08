//
//  SearchPage.swift
//  blacktube
//
//  Created by kiakim on 2023/09/05.
//

import UIKit

class SearchPage: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    var searchVideos: [Video] = []
    var searchIndex: [Int] = []
    
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
//        icon.image = UIImage(systemName: "magnifyingglass")
//        icon.backgroundColor = UIColor.red
//        icon.tintColor = UIColor.gray
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
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(SearchItem), for: .editingChanged)
        
        return textField
    }()
    
    
    let micBox : UIView = {
        let micBox = UIView()
//        micBox.backgroundColor = UIColor(hex: "edede9")
//        micBox.layer.cornerRadius = 20
//        micBox.layer.masksToBounds = true
        return micBox
    }()
    
    let micIcon : UIImageView = {
        let icon = UIImageView()
//        icon.image = UIImage(systemName: "mic.fill")
//        icon.backgroundColor = UIColor.red
//        icon.tintColor = UIColor.black
        return icon
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchTableView.reloadData()
    }
    
}

extension SearchPage{
    func configureUI(){
        setAppLogoToNavigationBar()
        view.addSubview(searchBox)
        searchBox.addSubview(searchIcon)
        searchBox.addSubview(micBox)
        searchBox.addSubview(searchTextField)
        micBox.addSubview(micIcon)
    }
    func setLayout(){
        searchBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBox.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 35),
            searchBox.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            searchBox.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: -5),
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
        searchIndex = []
        for i in 0..<videos.count {
            if videos[i].title.lowercased().contains(key.lowercased()) {
                searchVideos.append(videos[i])
                searchIndex.append(i)
            }
        }
        self.searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let video = videos[searchIndex[indexPath.row]]
        cell.heartButton.tag = searchIndex[indexPath.row]
        cell.SetupUI(video)
        cell.heartButton.addTarget(self, action: #selector(ClickButton), for: .touchUpInside)
        return cell
    }
    
    @objc func ClickButton (_ sender: UIButton) {
        let video = videos[sender.tag]
        if !likedVideos.contains(video) {
            likedVideos.append(video)
            sender.tintColor = .red
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            for i in 0..<likedVideos.count {
                if likedVideos[i] == video {
                    likedVideos.remove(at: i)
                    break
                }
            }
            sender.tintColor = .gray
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        videos[sender.tag].isLiked.toggle()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = searchVideos[indexPath.row]
        performSegue(withIdentifier: "SearchToDetail", sender: selectedVideo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            if let detailVC = segue.destination as? DetailViewController {
                if let selectedVideo = sender as? Video {
                    detailVC.video = selectedVideo
                }
            }
        }
    }
    
    func setAppLogoToNavigationBar() {
        let logoImageView = UIImageView(image: UIImage(named: "blacktube_applogo_black"))
        logoImageView.frame = CGRect(x: 20, y: 5, width: 40, height: 27)
        navigationBar.addSubview(logoImageView)
    }
}

extension SearchPage: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
