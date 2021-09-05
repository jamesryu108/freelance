//
//  CustomTextView.swift
//  CustomTextView
//
//  Created by James Ryu on 2021-09-04.
//

import Foundation
import UIKit

class CustomTextView: UITextView {
        
    var size: CGFloat
    var weight: FontStyle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        self.size = 18
        self.weight = .regular
        
        super.init(frame: CGRect.zero, textContainer: nil)

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
