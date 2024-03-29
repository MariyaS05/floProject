//
//  TextField.swift
//  floProject2
//
//  Created by Мария  on 13.01.23.
//

import Foundation
import UIKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(placeholder: String,textContentType: UITextContentType,secure : Bool){
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.textContentType = textContentType
        self.isSecureTextEntry =  secure
        configure()
    }
    private func configure(){
        translatesAutoresizingMaskIntoConstraints =  false
        layer.cornerRadius =  10
        layer.borderWidth =  2
        layer.borderColor =  UIColor.white.cgColor
        
        textColor = .secondaryLabel
        tintColor = .secondaryLabel
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType.self = .no
        returnKeyType = .go
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , 10 , 10)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , 10 , 10)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
        
    }
}
