//
//  Geometry.swift
//  Ex3DieRoller
//
//  Created by Vladislav Maltsev on 08.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Foundation

extension NSRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + 0.5 * size.width,
                       y: origin.y + 0.5 * size.height)
    }
    
    func centeredRect(withSize size: CGSize) -> NSRect {
        return NSRect(x: center.x - 0.5 * size.width,
                      y: center.y - 0.5 * size.height,
                      width: size.width,
                      height: size.height)
    }
}
