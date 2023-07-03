//
//  Goal.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/04.
//

import Foundation

struct GoalList: Codable {
    let goalList: [Goal]
    
    enum CodingKeys: String, CodingKey {
        case goalList = "result"
    }
}

struct Goal: Codable {
    let goalID: Int
    let title, startDate, endDate: String
    let goalCount: Int  // 목표 횟수
    let user: User
    let period, count: Int  // 주기, 현재까지 한 횟수

    enum CodingKeys: String, CodingKey {
        case goalID = "goalId"
        case title, startDate, endDate, goalCount, user, period, count
    }
}

struct NewGoal: Codable {
    var userId: Int
    var title: String
    var goalCount: Int
    var period: Int
}