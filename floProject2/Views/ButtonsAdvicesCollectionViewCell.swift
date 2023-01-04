//
//  ButtonsAdvicesCollectionViewCell.swift
//  floProject2
//
//  Created by Мария  on 27.11.22.
//

import UIKit

class ButtonsAdvicesCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "ButtonsAdvicesCollectionViewCell"
    
    var button = UIButton()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(button)
        button.frame = self.bounds
        button.clipsToBounds =  true
        button.makeButtom()
//        button.addTarget(self, action: #selector(buttonTapped ), for: .touchUpInside)
//        button.addTarget(self, action: #selector(secondButtonTapped ), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure (with title : Advice) {
        button.setTitle(title.imageName, for: .normal)
    }
    @objc func buttonTapped() {
        print( "All cases")
    }
    @objc func secondButtonTapped(){
        print("Saved information")
    }
}
    

