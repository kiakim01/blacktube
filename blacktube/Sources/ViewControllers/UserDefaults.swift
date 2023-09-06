//
//  UserDefaults.swift
//  blacktube
//
//  Created by kiakim on 2023/09/06.
//

import Foundation

class UserData {
    var id : String?
    var password : String?
    var name : String?
    var email : String?
    
}

class UserManager {
    static let shared = UserManager() // Singleton instance
    var userData: [UserData] = []
}
