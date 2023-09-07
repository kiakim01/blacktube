//
//  UserDefaults.swift
//  blacktube
//
//  Created by kiakim on 2023/09/06.
//

import Foundation

class UserData {
    
//  static let shered = UserData()
    
    var id : String?
    var password : String?
    var name : String?
    var email : String?
    
}

//상훈님 코드에 첨부 ..!
class UserManager {
    static let shared = UserManager() // Singleton instance

}


