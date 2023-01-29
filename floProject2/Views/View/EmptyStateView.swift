//
//  EmptyStateView.swift
//  floProject2
//
//  Created by Мария  on 5.01.23.
//

import UIKit

class EmptyStateView: UIView {
    let messageLabel = TitleLabel(fontSize: 18, weight: .regular, textAlignment: .natural)
    let buttonStartSearch = Button(title: "Начать поиск", textColor: Color.pinkColor)
    let imageView =  UIImageView()
    weak var delegate : AdvicesViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init(messageLabel: String) {
        super.init(frame: .zero)
        self.messageLabel.text = messageLabel
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        let padding : CGFloat =  15
        backgroundColor = .white
        addSubview(messageLabel)
        addSubview(buttonStartSearch)
        addSubview(imageView)
        
        buttonStartSearch.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
        messageLabel.textColor = .lightGray
        
        imageView.image = UIImage(named: "emptyView")
        imageView.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: 80),
            
            buttonStartSearch.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: padding),
            buttonStartSearch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStartSearch.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    @objc func addAction(){
        delegate?.didStartSearchingButtonTapped()
    }
}
