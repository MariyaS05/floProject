//
//  UserInfoModel.swift
//  floProject2
//
//  Created by Мария  on 25.01.23.
//

import Foundation
struct UserInfo : Codable {
    var login : String
    var password : String
    var name : String
    var email : String
    var dateOfBirth : Date
    var dateOfPeriod : Date
    var dateOfNextPeriod : Date?
}
