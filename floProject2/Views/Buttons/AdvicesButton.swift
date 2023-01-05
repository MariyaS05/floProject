//
//  AdvicesButton.swift
//  floProject2
//
//  Created by Мария  on 4.01.23.
//

import UIKit

class AdvicesButton: UIButton {
    weak var delegate : AdvicesDelegate?
    var isSelectedButton: Bool =  false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        clipsToBounds =  true
        makeButtom()
        addTarget(self, action: #selector(advicesButtonTapped), for: .touchUpInside)
    }
    @objc func advicesButtonTapped(){
          
    }
}
