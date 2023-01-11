//
//  ButtonsAdvicesCollectionViewCell.swift
//  floProject2
//
//  Created by Мария  on 27.11.22.
//

import UIKit

class ButtonsAdvicesCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "ButtonsAdvicesCollectionViewCell"
    
    var buttonAllAdvices = AllAdvicesButton(frame: .zero)
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(buttonAllAdvices)
        buttonAllAdvices.frame =  self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure (with title : Advice) {
        buttonAllAdvices.setTitle(title.title, for: .normal)
    }
}


