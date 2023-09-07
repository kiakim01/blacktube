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
}

var userData: [User] = []
var loginUser: User = User(Id: "", password: "", userName: "", userEmail: "")


class UserManager {
    static let shared = UserManager() // Singleton instance

}
