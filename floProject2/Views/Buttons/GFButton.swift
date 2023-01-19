//
//  GFButton.swift
//  floProject2
//
//  Created by Мария  on 5.01.23.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init(title : String,textColor : UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        backgroundColor = .systemBackground
//        setTitleColor(.systemGray,for: .normal)
        translatesAutoresizingMaskIntoConstraints =  false
        layer.cornerRadius =  10
    }
    func setButton(with backgroundColor : UIColor,title : String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
