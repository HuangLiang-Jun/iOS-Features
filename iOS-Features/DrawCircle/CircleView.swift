//
//  CircleView.swift
//  iOS-Features
//
//  Created by liangJun on 2018/11/8.
//


import UIKit


class CircleView: UIView {
    
    
    // CGFloat.pi * 2 * progress 弧度
    var progress: CGFloat = 0 {
        didSet{
            if self.circleLayer != nil {
                let circlePath = UIBezierPath(arcCenter: center, radius: self.frame.width / 2, startAngle: 0 , endAngle: CGFloat.pi * 2 * progress, clockwise: true)
                self.circleLayer?.path = circlePath.cgPath
            }
        }
    }
    
    
    var circleLayer: CAShapeLayer? = nil
    override func draw(_ rect: CGRect) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 5
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: self.frame.width / 2,
                                      startAngle: 0 ,
                                      endAngle: CGFloat.pi * 2 * progress,
                                      clockwise: true)
        
        shapeLayer.path = circlePath.cgPath
        layer.addSublayer(shapeLayer)
        self.circleLayer = shapeLayer
        
        
    }

    
    
}
