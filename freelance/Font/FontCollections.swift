//
//  FontCollections.swift
//  FontCollections
//
//  Created by James Ryu on 2021-09-01.
//

import UIKit

/// FontType has two values, funkisQText and kievitCompPro. This will allow me to choose one of these fonts to use in the app. This should allow me to make font options exhaustive.
enum FontType {
    case funkisQText
    case kievitCompPro
}
/// FontStyle has five values.
enum FontStyle {
    case bold
    case light
    case medium
    case regular
    case semiBold
}

/// class that manages font being used in this application
class MyFontCollections {
        
    /// Hold FontType enum value
    var fontName: FontType
    
    init(fontName: FontType = .funkisQText) {
        self.fontName = fontName
        //printFonts()
    }
    
    /// Return an appropriate font based on what font you have selected.
    func returnFont(size: CGFloat, weight: FontStyle? = nil) -> UIFont {
        
        // Holds UIFont object
        var font: UIFont = UIFont()
        
        switch fontName {
        case .funkisQText: font = funkisQText(size: size, weight: weight!)
        case .kievitCompPro: font = kievitCompPro(size: size)
        }
        
        return font
    }
    
    /// Produce funkisQText fonts, by five different weights and sizes.
    func funkisQText(size: CGFloat, weight: FontStyle) -> UIFont {
        switch weight {
            case .regular: return UIFont(name: "FunkisQText-Regular", size: size)!
            case .bold: return UIFont(name: "FunkisQText-Bold", size: size)!
            case .light: return UIFont(name: "FunkisQText-Light", size: size)!
            case .medium: return UIFont(name: "FunkisQText-Medium", size: size)!
            case .semiBold: return UIFont(name: "FunkisQText-SemiBold", size: size)!
        }
    }
    
    /// Produce funkisQText fonts, by five different weights and sizes.
    func kievitCompPro(size: CGFloat) -> UIFont {
        return UIFont(name: "KievitCompPro-Exlig", size: size)!
    }
    
    /// Print all the fonts available and their families
    func printFonts() {
        for familyName in UIFont.familyNames {
            print("\n--\(familyName) \n")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(fontName)
            }
        }
    }
}
