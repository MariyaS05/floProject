//
//  DatesView.swift
//  floProject2
//
//  Created by Мария  on 29.01.23.
//

import UIKit

class DatesView: UIView {
    
    let firstStack =  UIStackView()
    let secondStack = UIStackView()
    let lastMnstrLabelText = TitleLabel(fontSize: 16, weight: .medium, textAlignment: .left)
    let nextMnstrLabelText = TitleLabel(fontSize: 16, weight: .medium, textAlignment: .left)
    let dateLastMnstrLabel = TitleLabel(fontSize: 16, weight: .medium, textAlignment: .center)
    let dateNextMnstrLabel = TitleLabel(fontSize: 16, weight: .medium, textAlignment: .center)
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        
        addSubview(firstStack)
        addSubview(secondStack)
        firstStack.translatesAutoresizingMaskIntoConstraints =  false
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.addArrangedSubview(lastMnstrLabelText)
        firstStack.addArrangedSubview(dateLastMnstrLabel)
        
        secondStack.addArrangedSubview(nextMnstrLabelText)
        secondStack.addArrangedSubview(dateNextMnstrLabel)
        
        firstStack.axis = .horizontal
        firstStack.distribution = .fillEqually
        
        secondStack.axis = .horizontal
        secondStack.distribution = .fillEqually
        
        lastMnstrLabelText.text = "Дата последних месячных:"
        nextMnstrLabelText.text = "Предварительная дата начала следующих месячных:"
        
        NSLayoutConstraint.activate([
            firstStack.topAnchor.constraint(equalTo: self.topAnchor),
            firstStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            firstStack.heightAnchor.constraint(equalToConstant: 60),
            secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 10),
            secondStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            secondStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            secondStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func configureDate(for label :UILabel,with date: Date){
        label.text = date.convertToDayMonthFormat()
    }
}
