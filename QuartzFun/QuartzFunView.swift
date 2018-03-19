//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by Zachary Calderone on 3/19/18.
//  Copyright © 2018 Black Kobold Games. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat( Double( arc4random_uniform( 255))/255)
        let green = CGFloat( Double( arc4random_uniform( 255))/255)
        let blue = CGFloat( Double( arc4random_uniform( 255))/255)
        return UIColor( red: red, green: green, blue: blue, alpha: 1.0)
    }
}

enum Shape : Int {
    case line = 0, rect, ellipse, image
}

// The color tab indices
enum DrawingColor : Int {
    case red = 0, blue, yellow, green, random
}

class QuartzFunView: UIView {
    // Application-settable properties
    var shape = Shape.line
    var currentColor = UIColor.red
    var useRandomColor = false
    
    // Internal properties
    private let image = UIImage( named:"iphone")
    private var firstTouchLocation = CGPoint.zero
    private var lastTouchLocation = CGPoint.zero

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set < UITouch >, with event: UIEvent?) {
        if let touch = touches.first {
            if useRandomColor {
                currentColor = UIColor.randomColor()
            }
            firstTouchLocation = touch.location( in: self)
            lastTouchLocation = firstTouchLocation
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set < UITouch >, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location( in: self)
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set < UITouch >, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location( in: self)
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth( 2.0)
        context?.setStrokeColor( currentColor.cgColor)
        context?.setFillColor( currentColor.cgColor)
        let currentRect = CGRect( x: firstTouchLocation.x, y: firstTouchLocation.y, width: lastTouchLocation.x - firstTouchLocation.x, height: lastTouchLocation.y - firstTouchLocation.y)
        switch shape {
        case .line:
            context?.move( to: CGPoint( x: firstTouchLocation.x, y: firstTouchLocation.y))
            context?.addLine( to: CGPoint( x: lastTouchLocation.x, y: lastTouchLocation.y))
            context?.strokePath()
        case .rect:
            context?.addRect( currentRect)
            context?.drawPath( using: .fillStroke)
        case .ellipse:
            context?.addEllipse( in: currentRect)
            context?.drawPath( using: .fillStroke)
        case .image:
            let horizontalOffset = image!.size.width / 2
            let verticalOffset = image!.size.height / 2
            let drawPoint = CGPoint( x: lastTouchLocation.x - horizontalOffset, y: lastTouchLocation.y - verticalOffset)
            image!.draw( at: drawPoint)
            }
        }
    
    

}
