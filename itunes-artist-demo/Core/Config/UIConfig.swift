//
//  UIConfig.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import UIKit


enum Colors {
    // Boton principal
    enum primaryButton {
        static let backgroundNormal         = UIColor(hex: "#F62A2F")
        static let backgroundHighlighted    = UIColor(hex: "#E61045")
        static let title                    = UIColor.white
    }
    
    // celdas
    enum cell {
        static let backgroundOdd            = UIColor.white
        static let backgroundEven           = UIColor.lightGray.withAlphaComponent(0.07)
    }
    
    // search field
    enum searchField {
        static let borderColor              = UIColor.lightGray.withAlphaComponent(0.5)
    }
}


extension UIButton {
    func stylePrimaryButton() {
        layer.cornerRadius = 6
        clipsToBounds = true
        
        setTitleColor(Colors.primaryButton.title, for: .normal)
        setBackgroundImage(UIImage(color: Colors.primaryButton.backgroundNormal), for: .normal)
        setBackgroundImage(UIImage(color: Colors.primaryButton.backgroundHighlighted), for: .highlighted)
    }
}

extension UITableViewCell {
    
    // impar
    func styleOddRow() {
        backgroundColor = Colors.cell.backgroundOdd
    }
    
    // par
    func styleEvenRow() {
        backgroundColor = Colors.cell.backgroundEven
    }
}

extension UITextField {
    func styleSearchField() {
        let border  = CALayer()
        let width   = CGFloat(0.5)
        border.borderColor = Colors.searchField.borderColor.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width:  frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        clipsToBounds = true
    }
}

extension UIView {
    func styleSearchView() {
        layer.cornerRadius = 4
        clipsToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
    }
}
