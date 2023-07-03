//
//  User.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/04.
//

import Foundation

struct User: Codable {
    let id: Int
    let email, password, name: String
}
