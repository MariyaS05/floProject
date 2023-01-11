//
//  AllAdvicesButton.swift
//  floProject2
//
//  Created by Мария  on 4.01.23.
//

import UIKit

class AllAdvicesButton : AdvicesButton {
    
    
    override func advicesButtonTapped() {
    
        delegate?.didAllAdvicesButtonTapped()
    }
}
