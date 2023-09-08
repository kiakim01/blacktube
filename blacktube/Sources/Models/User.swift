//
//  User.swift
//  blacktube
//
//  Created by Sanghun K. on 2023/09/07.
//

import Foundation

struct User: Codable {
    var Id: String
    var password: String
    var profileImage: Data?
    var userName: String
    var userEmail: String
    var likedVideos: [Video] = []
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.Id == rhs.Id
        }
}

//로그인페이지 확인용 더미데이터
var guest = User(Id: "Guest", password: "0000", userName: "Guest", userEmail: "none")
var user1 = User(Id: "lcho3878", password: "102030", userName: "이찬호", userEmail: "leech3878@naver.com")
var user2 = User(Id: "leech3878", password: "124578", userName: "찬호", userEmail: "leech3878@google.com")
var userData: [User] = [user1, user2]
var loginUser = guest


class UserManager {
    static let shared = UserManager() // Singleton instance
    let encoder = JSONEncoder()
    
    func SaveUserData(){
        if let encodedUserData = try? encoder.encode(userData) {
            UserDefaults.standard.set(encodedUserData, forKey: "userData")
        }
    }
    
    func SaveLoginUser() {
        if let encodedLoginUser = try? encoder.encode(loginUser) {
            UserDefaults.standard.set(encodedLoginUser, forKey: "loginUser")
        }
    }
    
    func LoadUserData() {
        if let savedUserData = UserDefaults.standard.object(forKey: "userData") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([User].self, from: savedUserData) {
                userData = savedObject
            }
        }
    }
    
    func LoadLoginUser() {
        if let savedLoginUser = UserDefaults.standard.object(forKey: "loginUser") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(User.self, from: savedLoginUser) {
                loginUser = savedObject
            }
        }
    }
        
        
    
}
