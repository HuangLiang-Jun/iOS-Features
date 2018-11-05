//
//  UIbarButtonItem+Badge.swift
//  iOS-Features
//
//  Created by liangJun on 2018/11/5.
//

import Foundation
import UIKit

private var handle: UInt8 = 11


extension CAShapeLayer {
    fileprivate func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, color: UIColor, filled: Bool) {
        
        
        fillColor = filled ? color.cgColor : UIColor.white.cgColor // fill color
        
        strokeColor = UIColor.white.cgColor // border color
        
        let origin = CGPoint(x: location.x - radius,
                             y: location.y - radius) // draw degion
        
        path = UIBezierPath(ovalIn: CGRect(origin: origin,
                                           size: CGSize(width: radius * 2,
                                                        height: radius * 2))).cgPath
        
    }
}


extension UIBarButtonItem {
    
    /// Get badge layer.
    private var badgeLayer: CAShapeLayer? {
       
        if let shapeLayer: Any = objc_getAssociatedObject(self, &handle) {
            
            return shapeLayer as? CAShapeLayer
        }
        print("nil")
        return nil
    }
    
    
    
    
    /// NavigationBarButtomItem Badge
    ///
    /// - Parameters:
    ///   - number: 顯示數字
    ///   - offset: 顯示位置 , Default = 0
    ///   - color: badge顏色, Default = red
    ///   - filled: 是否填滿, Default = true
    func setBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, color: UIColor = .red, filled: Bool = true) {
        
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        self.removeBadge()
        
        if number == 0 { return }
        
        var badgeWidth: CGFloat = 8
        
        var numberOffset: CGFloat = 4
       
        if number > 9 {
            
            badgeWidth = 32
            
            numberOffset = 16
        }
        
        let shapeLayer = CAShapeLayer()
       
        let radius = CGFloat(7)
        
        let location = CGPoint(x: view.frame.width  - (radius + offset.x),
                               y: radius + offset.y)
        
        shapeLayer.drawCircleAtLocation(location: location,
                                   withRadius: radius,
                                   color: color,
                                   filled: filled)
        
        view.layer.addSublayer(shapeLayer)
        
        // https://zsisme.gitbooks.io/ios-/content/chapter6/CATextLayer.html
        let textLayer = CATextLayer()
        textLayer.string = "\(number)"
        textLayer.alignmentMode = .center
        textLayer.fontSize = 11
        textLayer.frame = CGRect(origin: CGPoint(x: location.x - numberOffset, y: offset.y) , size: CGSize(width: badgeWidth, height: 16))
        textLayer.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.contentsScale = UIScreen.main.scale 
        shapeLayer.addSublayer(textLayer)
        
        
        objc_setAssociatedObject(self, &handle, shapeLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    
    func updateBadge(number: Int) {
        if number == 0 {
            self.removeBadge()
            return
        }
        self.setBadge(number: number)
    }
    
    private func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
        
    }
}
