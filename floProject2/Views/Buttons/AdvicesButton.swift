//
//  AdvicesButton.swift
//  floProject2
//
//  Created by Мария  on 4.01.23.
//

import UIKit

class AdvicesButton: UIButton {
    
    var isSelectedButton: Bool =  false
    
    
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
    func configure(){
        clipsToBounds =  true
        makeButtom()
        addTarget(self, action: #selector(advicesButtonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func advicesButtonTapped(){
        
    }
}
