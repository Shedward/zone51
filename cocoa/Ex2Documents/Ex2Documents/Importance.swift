//
//  Importance.swift
//  Ex2Documents
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Cocoa

@objc enum Importance: Int {
    case normal
    case question
    case warning
    case danger
}

extension Importance {
    var icon: NSImage {
        switch self {
        case .normal:
            return #imageLiteral(resourceName: "Normal")
        case .question:
            return #imageLiteral(resourceName: "Question")
        case .warning:
            return #imageLiteral(resourceName: "Warning")
        case .danger:
            return #imageLiteral(resourceName: "Danger")
        }
    }
}
