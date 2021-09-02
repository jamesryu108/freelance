//
//  Anchor.swift
//  Quit & Run
//
//  Created by James Ryu on 2020-08-07.
//  Copyright © 2020 James Ryu. All rights reserved.
//

import UIKit

extension UIView {

    func anc(t: NSLayoutYAxisAnchor? = nil, ver: CGFloat? = nil, b: NSLayoutYAxisAnchor? = nil, l: NSLayoutXAxisAnchor? = nil, hor: CGFloat? = nil, r: NSLayoutXAxisAnchor? = nil, w: CGFloat? = nil, h: CGFloat? = nil, cX: NSLayoutXAxisAnchor? = nil, cY: NSLayoutYAxisAnchor? = nil) {
        
            translatesAutoresizingMaskIntoConstraints = false

        if let top = t {
            topAnchor.constraint(equalTo: top, constant: ver!).isActive = true
        }
        if let bottom = b {
            bottomAnchor.constraint(equalTo: bottom, constant: -ver!).isActive = true
        }
        if let right = r {
            rightAnchor.constraint(equalTo: right, constant: -hor!).isActive = true
        }
        if let left = l {
            leftAnchor.constraint(equalTo: left, constant: hor!).isActive = true
        }
        
        if let width = w {
        
            if width != 0 {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
        
        if let height = h {
            
            if height != 0 {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
            if let centerX = cX {
                centerXAnchor.constraint(equalTo: centerX).isActive = true
            }
            
            if let centerY = cY {
                centerYAnchor.constraint(equalTo: centerY).isActive = true
            }
        }
}
