//
//  CustomLabel.swift
//  CustomLabel
//
//  Created by James Ryu on 2021-09-01.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
        
    var size: CGFloat
    var weight: FontStyle
    
    override init(frame: CGRect) {
        
        self.size = 18
        self.weight = .regular
        
        super.init(frame: frame)
        
        self.font = MyFontCollections(fontName: .funkisQText).returnFont(size: size, weight: weight)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(size: CGFloat, weight: FontStyle, fontName: FontType? = .funkisQText) {
        
        self.init()
        
        font = MyFontCollections(fontName: .funkisQText).returnFont(size: size, weight: weight)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
