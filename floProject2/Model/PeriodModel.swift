//
//  PeriodModel.swift
//  floProject2
//
//  Created by Мария  on 19.01.23.
//

import Foundation
struct Period :Codable {
    var dateOfStartperiod :Date
    var endOfMenstruation : Date
    var startOfOvulation : Date
    var endOfOvulation: Date
    var endOfCycle: Date
    var ovulationDay : Date
    var durationOfMenstruation : [String]
    var durationOfOvulation : [String]
    var durationOfCycle : [String]
}
