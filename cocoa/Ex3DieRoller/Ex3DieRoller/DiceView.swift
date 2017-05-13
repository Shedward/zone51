//
//  DiceView.swift
//  Ex3DieRoller
//
//  Created by Vladislav Maltsev on 08.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Cocoa
import QuartzCore

class DiceView: NSView {
    
    // MARK: Properties
    
    @IBInspectable
    var roll: UInt = 5
    
    @IBInspectable
    var diceColor: NSColor = .white {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    @IBInspectable
    var dotColor: NSColor = .black {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    @IBInspectable
    var padding: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    @IBInspectable
    var diceCornerRadiusCoeff: CGFloat = 0.25 {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    @IBInspectable
    var font: NSFont = NSFont.systemFont(ofSize: 32.0) {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    // MARK: Lifecycle
    
    override func layout() {
        super.layout()
        
        setNeedsDisplay(bounds)
    }
    
    // MARK: Computed metrics
    
    var dotRadius: CGFloat {
        return 0.5 * diceWidth / 7.0
    }
    
    var diceWidth: CGFloat {
        let minSize = min(bounds.width, bounds.height)
        return minSize - 2.0 * padding
    }
    
    var diceRect: NSRect {
        return NSRect(x: bounds.center.x - 0.5 * diceWidth,
                      y: bounds.center.y - 0.5 * diceWidth,
                      width: diceWidth,
                      height: diceWidth)
    }
    
    var diceCornerRadius: CGFloat {
        return diceWidth * diceCornerRadiusCoeff
    }
    
    // MARK: Drawing
    
    override func draw(_ dirtyRect: NSRect) {
        drawBackground()
        drawRoll()
    }
    
    private func drawBackground() {
        let backgroundPath = NSBezierPath(roundedRect: diceRect,
                                          xRadius: diceCornerRadius,
                                          yRadius: diceCornerRadius)
        
        diceColor.set()
        backgroundPath.fill()
    }
    
    private func drawRoll() {
        switch roll {
        case 1:
            drawDot(ax: 0.5, ay: 0.5)
            
        case 2:
            drawDot(ax: 0.33, ay: 0.33)
            drawDot(ax: 0.66, ay: 0.66)
            
        case 3:
            drawDot(ax: 0.25, ay: 0.25)
            drawDot(ax: 0.50, ay: 0.50)
            drawDot(ax: 0.75, ay: 0.75)
            
        case 4:
            drawDot(ax: 0.25, ay: 0.25)
            drawDot(ax: 0.25, ay: 0.75)
            drawDot(ax: 0.75, ay: 0.25)
            drawDot(ax: 0.75, ay: 0.75)
            
        case 5:
            drawDot(ax: 0.25, ay: 0.25)
            drawDot(ax: 0.25, ay: 0.75)
            drawDot(ax: 0.75, ay: 0.25)
            drawDot(ax: 0.75, ay: 0.75)
            drawDot(ax: 0.50, ay: 0.50)
            
        case 6:
            drawDot(ax: 0.25, ay: 0.25)
            drawDot(ax: 0.25, ay: 0.75)
            drawDot(ax: 0.75, ay: 0.25)
            drawDot(ax: 0.75, ay: 0.75)
            drawDot(ax: 0.25, ay: 0.50)
            drawDot(ax: 0.75, ay: 0.50)
            
        default:
            drawNumber()
        }
    }
    
    private func drawDot(ax: CGFloat, ay: CGFloat) {
        let center = CGPoint(x: diceRect.minX + ax * diceWidth,
                             y: diceRect.minY + ay * diceWidth)
        
        let dotRect = CGRect(x: center.x - dotRadius,
                             y: center.y - dotRadius,
                             width:  2.0 * dotRadius,
                             height: 2.0 * dotRadius)
        
        let dotPath = NSBezierPath(ovalIn: dotRect)
        
        dotColor.set()
        dotPath.fill()
    }
    
    private func drawNumber() {
        let string = "\(roll)" as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [String : Any] = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: dotColor,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        
        let requiredTextSize = string.size(withAttributes: attributes)
        let actualTextRect = diceRect.centeredRect(withSize: requiredTextSize)

        string.draw(in: actualTextRect, withAttributes: attributes)
    }
}
