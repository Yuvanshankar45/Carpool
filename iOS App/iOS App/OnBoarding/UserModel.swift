//
//  UserModel.swift
//  iOS App
//
//  Created by Yuvan Shankar on 16/09/2023.
//

import Foundation

struct UserRegistration: Codable {
    let name, email, phoneNumber, password: String?
    let address: String?
}

// MARK: - DataClass
struct AccessToken: Codable {
    let accessToken: String?
}

struct LoginResponse: Codable {
    let success: Bool?
    let error: String?
    let data: AccessToken?
}

struct UserData: Codable {
    let success: Bool?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let name, email, password, phoneNumber: String?
    let address, ethereumAddress, id, createdAt: String?
    let updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case name, email, password, phoneNumber, address, ethereumAddress
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
