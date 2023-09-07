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
    var likedVideos: [Video]?
}

//로그인페이지 확인용 더미데이터
var user1 = User(Id: "lcho3878", password: "102030", userName: "이찬호", userEmail: "leech3878@naver.com")
var user2 = User(Id: "leech3878", password: "124578", userName: "찬호", userEmail: "leech3878@google.com")
var userData: [User] = [user1, user2]
var loginUser: User = User(Id: "", password: "", userName: "", userEmail: "")


class UserManager {
    static let shared = UserManager() // Singleton instance

}
