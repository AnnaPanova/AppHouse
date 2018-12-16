//
//  SecondCell.swift
//  App для домашних дел
//
//  Created by Анна on 27.09.18.
//  Copyright © 2018 Анна. All rights reserved.
//

import UIKit

class SecondCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.textColor = .black
        self.textLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    func setText(_ text: String, isDone: Bool) {
        if isDone {
            // MARK: Strikethrough font
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            textLabel?.attributedText = attributedString
        } else {
            textLabel?.text = text
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = nil
        textLabel?.attributedText = nil
    }
}
