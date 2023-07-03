//
//  GoalService.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/04.
//

import Foundation

class GoalService {
    static let shared = GoalService()
    private init() {}
    
    func requestGoalList(userId: Int, completion: @escaping ([Goal])->()) {
        guard let url = URL(string: "\(Bundle.main.REST_API_URL)/goal/getGoal/\(userId)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            
            guard err == nil else {
                print("Error: error calling POST")
                print(err)
                return
            }
            
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
            guard let response = res as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(GoalList.self, from: safeData)
                    dump(decodedData)
                    completion(decodedData.goalList)
                } catch {
                    print("Decode Error")
                }
            }
            
        }.resume()
    }
    
    func createNewGoal(newGoal: NewGoal, completion: @escaping ()->()) {
        guard let url = URL(string: "\(Bundle.main.REST_API_URL)/goal") else { return }
        
        guard let jsonData = try? JSONEncoder().encode(newGoal) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            
            guard err == nil else {
                print("Error: error calling POST")
                print(err)
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
            guard let response = res as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            completion()
        }.resume()
    }
}
