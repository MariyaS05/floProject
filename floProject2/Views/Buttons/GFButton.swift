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
    init(title : String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        backgroundColor = .systemBackground
        setTitleColor(UIColor(red: 255/255, green: 89/255, blue: 124/255, alpha: 1), for: .normal)
        translatesAutoresizingMaskIntoConstraints =  false
    }
    func setButton(with backgroundColor : UIColor,title : String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
