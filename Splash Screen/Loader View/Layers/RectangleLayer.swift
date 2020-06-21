//
//  RectangleLayer.swift
//  Launch Screen
//
//  Created by Ayman Ata on 6/15/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {
  
  override init() {
    super.init()
    fillColor = UIColor.clear.cgColor
    lineWidth = 5.0
    path = rectanglePathFull.cgPath
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var rectanglePathFull: UIBezierPath {
    let rectanglePath = UIBezierPath()
    rectanglePath.move(to: CGPoint(x: 0.0, y: 140.0))
    rectanglePath.addLine(to: CGPoint(x: 0.0, y: -lineWidth))
    rectanglePath.addLine(to: CGPoint(x: 140.0, y: -lineWidth))
    rectanglePath.addLine(to: CGPoint(x: 140.0, y: 140.0))
    rectanglePath.addLine(to: CGPoint(x: -lineWidth / 2, y: 140.0))
    rectanglePath.close()
    return rectanglePath
  }
  
  func animateStrokeWithColor(color: UIColor) {
    strokeColor = color.cgColor
    let strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeAnimation.fromValue = 0.0
    strokeAnimation.toValue = 1.0
    strokeAnimation.duration = 0.4
    add(strokeAnimation, forKey: nil)
  }

}
