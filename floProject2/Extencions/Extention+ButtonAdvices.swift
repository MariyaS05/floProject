//
//  Extention.swift
//  floProject2
//
//  Created by Мария  on 15.09.22.
//

import Foundation
import UIKit


extension UIButton {
    func makeButtom () {
        layer.cornerRadius = 15
        titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        backgroundColor = UIColor(cgColor: CGColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1))
        setTitleColor(.black, for: .normal)
        
//        backgroundColor = UIColor(cgColor: CGColor(red: 255/255, green: 66/255, blue: 113/255, alpha: 1))
    }
}
extension UIStackView {
    func makeStack (){
        axis = .horizontal
        distribution = .fillEqually
        spacing = 15
    }
    
}

