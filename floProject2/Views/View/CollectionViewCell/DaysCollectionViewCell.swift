//
//  DaysCollectionViewCell.swift
//  floProject2
//
//  Created by Мария  on 22.01.23.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    
    static var reuseId =  "DaysCollectionViewCell"
    let firstTitleLabel = TitleLabel(fontSize: 14, weight: .medium, textAlignment: .center)
    let daysTitleLabel = TitleLabel(fontSize: 20, weight: .bold, textAlignment: .center)
    let discriptionTitleLabel = TitleLabel(fontSize: 12, weight: .regular, textAlignment: .center)
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let padding : CGFloat = 20
        contentView.addSubview(firstTitleLabel)
        contentView.addSubview(daysTitleLabel)
        contentView.addSubview(discriptionTitleLabel)
       
        backgroundColor = .red
      
        
        NSLayoutConstraint.activate([
            firstTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            firstTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            firstTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            firstTitleLabel.heightAnchor.constraint(equalToConstant: padding),
            
            daysTitleLabel.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: padding),
            daysTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            daysTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            daysTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            discriptionTitleLabel.topAnchor.constraint(equalTo: daysTitleLabel.bottomAnchor, constant: padding),
            discriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding/2),
            discriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding/2),
            discriptionTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        
        ])
    }
}
