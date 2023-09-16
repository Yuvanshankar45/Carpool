//
//  UserDefaultsManager.swift
//  iOS App
//
//  Created by Yuvan Shankar on 16/09/2023.
//

import Foundation

struct UserStorage {
    @Storage(key: "userName", defaultValue: "")
    static var userName: String
    
    @Storage(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @Storage(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
}
