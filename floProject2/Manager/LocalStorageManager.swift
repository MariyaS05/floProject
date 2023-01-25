//
//  LocalStorageManager.swift
//  floProject2
//
//  Created by Мария  on 25.01.23.
//

import Foundation
enum LocalStorageManager {
    static let defaults: UserDefaults = UserDefaults.standard
    enum Keys {
        static let user = "user"
        static let userInfo =  "userInfo"
    }
    static func saveUserInfo(userInfo : UserInfo) {
        var users :[UserInfo] = []
        users.append(userInfo)
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(users)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
            defaults.set(json, forKey: Keys.userInfo)
            defaults.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
    static func getUserInfo() -> [UserInfo] {
        var userInfo: [UserInfo] = []
        let jsonDecoder = JSONDecoder()
        do {
            if (LocalStorageManager.defaults.object(forKey: Keys.userInfo) == nil) {
                return []
            } else {
                let json = UserDefaults.standard.string(forKey: Keys.userInfo) ?? "{}"
                guard let jsonData = json.data(using: .utf8) else {
                    return []
                }
                userInfo = try jsonDecoder.decode([UserInfo].self, from: jsonData)
                return userInfo
            }
        } catch {
            print(error.localizedDescription)
        }
       return userInfo
    }
    static func saveUser(user : User ){
        var users :[User] = []
        users.append(user)
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(users)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
            defaults.set(json, forKey: Keys.user)
            defaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    static func getUser() -> [User] {
        var user: [User] = []
        let jsonDecoder = JSONDecoder()
        do {
            if (LocalStorageManager.defaults.object(forKey: Keys.user) == nil) {
                return []
            } else {
                let json = UserDefaults.standard.string(forKey: Keys.user) ?? "{}"
                guard let jsonData = json.data(using: .utf8) else {
                    return []
                }
                user = try jsonDecoder.decode([User].self, from: jsonData)
                return user
            }
        } catch {
            print(error.localizedDescription)
        }
       return user
    }
}
