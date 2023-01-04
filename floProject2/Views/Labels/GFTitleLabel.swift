//
//  GFTitleLabel.swift
//  floProject2
//
//  Created by Мария  on 30.12.22.
//

import UIKit

class GFTitleLabel: UILabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitle()
    }
    init(fontSize : CGFloat,weight : UIFont.Weight) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize,weight: weight)
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureTitle(){
        textColor = .label
        numberOfLines = 2
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
