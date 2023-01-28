//
//  AdvicesCell.swift
//  floProject2
//
//  Created by Мария  on 10.11.22.
//

import UIKit

class AdvicesCell: UICollectionViewCell {
    
    static var reuseId =  "AdvicesCell"
    let imageView = UIImageView()
    let titleLabel =  TitleLabel(fontSize: 16.5, weight: .medium, textAlignment: .left)
    let padding : CGFloat = 12
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureCell()
        setLayout()
        
    }
    private func setLayout(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo:imageView.bottomAnchor, constant: -padding),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: padding),
           titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1/4)
        ])
    }
    private func configureCell(){
        contentView.addSubview(imageView)
        imageView.addSubview(titleLabel)
        backgroundColor = UIColor(white: 1, alpha: 1)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (with image: Advice) {
        imageView.image = UIImage(named: image.imageName )
    }
    func configureTitle(with title : Advice) {
        titleLabel.text =  title.title
    }
}

