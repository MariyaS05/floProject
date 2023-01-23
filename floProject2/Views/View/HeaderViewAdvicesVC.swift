//
//  HeaderViewAdvicesVC.swift
//  floProject2
//
//  Created by Мария  on 10.11.22.
//

import UIKit

class HeaderViewAdvicesVC: UICollectionReusableView {
    static var reuseId =  "HeaderViewAdvicesVC"
    let titleLabel = GFTitleLabel(fontSize: 20, weight: .bold, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15)
        ])
    }
    func configure(with title : String) {
        titleLabel.text = title
    }
}
