//
//  GFButtonStartPeriod.swift
//  floProject2
//
//  Created by Мария  on 23.01.23.
//

import UIKit

class GFButtonStartPeriod: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints =  false
        layer.cornerRadius =  15
    }
    func setButton(with backgroundColor : UIColor,title : String, fontSize: CGFloat) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        self.titleLabel?.font =  UIFont.systemFont(ofSize: fontSize)
    }
   
}


