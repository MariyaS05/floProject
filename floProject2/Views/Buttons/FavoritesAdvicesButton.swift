//
//  FavoritesAdvicesButton.swift
//  floProject2
//
//  Created by Мария  on 4.01.23.
//

import UIKit

class FavoritesAdvicesButton: AdvicesButton {
   
   
    override func advicesButtonTapped() {
       
        delegate?.didFavoritesAdvicesButtonTapped()
    }
}
