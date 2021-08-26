//
//  CustomTextField.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/5/21.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        
        borderStyle = .none
        textColor = .black
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        setHeight(40)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 0, alpha: 0.5)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
