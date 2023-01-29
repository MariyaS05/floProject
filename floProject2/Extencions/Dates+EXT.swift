//
//  Dates+EXT.swift
//  floProject2
//
//  Created by Мария  on 15.01.23.
//

import Foundation
extension Date {
    func convertToMonthYearFormat()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    func convertToDayMonthFormat()->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
   
}
extension Date {
    
}
