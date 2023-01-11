//
//  ModelDetailAdvices.swift
//  floProject2
//
//  Created by Мария  on 7.01.23.
//

import Foundation
struct DetailAdvices : Hashable {
    let titleOfDetailAdvice: String
    let imageOfDetailAdvice : String
    
    init(titleOfDetailAdvice: String, imageOfDetailAdvice: String) {
        self.titleOfDetailAdvice = titleOfDetailAdvice
        self.imageOfDetailAdvice = imageOfDetailAdvice
    }
}
class AllDetailAdvices {
    var menstrualCycleDetailAdvices1 = [DetailAdvices]()
    var menstrualCycleDetailAdvices2 = [DetailAdvices]()

    init(){
        
    }
    func setup(){
        
    }
}


