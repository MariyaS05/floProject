//
//  AllAdvicesButton.swift
//  floProject2
//
//  Created by Мария  on 4.01.23.
//

import UIKit

class AllAdvicesButton : AdvicesButton {
    
    override func advicesButtonTapped() {
        isSelectedButton.toggle()
        
        if isSelectedButton ==  true {
            self.backgroundColor = .systemPink
        } else {
            self.backgroundColor = .systemGray
        }
        delegate?.didAllAdvicesButtonTapped()
    }
}
