//
//  TriangleLayer.swift
//  Launch Screen
//
//  Created by Ayman Ata on 6/15/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
  
  let innerPadding: CGFloat = 55.0
  
  override init() {
    super.init()
    fillColor = UIColor.red.cgColor
    strokeColor = UIColor.red.cgColor
    lineWidth = 7.0
    lineCap = CAShapeLayerLineCap.round
    lineJoin = CAShapeLayerLineJoin.round
    path = trianglePathSmall.cgPath
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var trianglePathSmall: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0 + innerPadding, y: 135.0))
    trianglePath.addLine(to: CGPoint(x: 70.0, y: 12.5 + innerPadding))
    trianglePath.addLine(to: CGPoint(x: 135.0 - innerPadding, y: 135.0))
    trianglePath.close()
    return trianglePath
  }
  
  var trianglePathLeftExtension: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0, y: 135.0))
    trianglePath.addLine(to: CGPoint(x: 70.0, y: 12.5 + innerPadding))
    trianglePath.addLine(to: CGPoint(x: 135.0 - innerPadding, y: 135.0))
    trianglePath.close()
    return trianglePath
  }
  
  var trianglePathRightExtension: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0, y: 135.0))
    trianglePath.addLine(to: CGPoint(x: 70.0, y: 12.5 + innerPadding))
    trianglePath.addLine(to: CGPoint(x: 135.0, y: 135.0))
    trianglePath.close()
    return trianglePath
  }
  
  var trianglePathTopExtension: UIBezierPath {
    let trianglePath = UIBezierPath()
    trianglePath.move(to: CGPoint(x: 5.0, y: 135.0))
    trianglePath.addLine(to: CGPoint(x: 70.0, y: 0))
    trianglePath.addLine(to: CGPoint(x: 135.0, y: 135.0))
    trianglePath.close()
    return trianglePath
  }
  
  func animate() {
    let triangleAnimationLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
    triangleAnimationLeft.fromValue = trianglePathSmall.cgPath
    triangleAnimationLeft.toValue = trianglePathLeftExtension.cgPath
    triangleAnimationLeft.beginTime = 0.0
    triangleAnimationLeft.duration = 0.3
    
    let triangleAnimationRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
    triangleAnimationRight.fromValue = trianglePathLeftExtension.cgPath
    triangleAnimationRight.toValue = trianglePathRightExtension.cgPath
    triangleAnimationRight.beginTime = triangleAnimationLeft.beginTime + triangleAnimationLeft.duration
    triangleAnimationRight.duration = 0.25
    
    let triangleAnimationTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
    triangleAnimationTop.fromValue = trianglePathRightExtension.cgPath
    triangleAnimationTop.toValue = trianglePathTopExtension.cgPath
    triangleAnimationTop.beginTime = triangleAnimationRight.beginTime + triangleAnimationRight.duration
    triangleAnimationTop.duration = 0.20
    
    let triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
    triangleAnimationGroup.animations = [triangleAnimationLeft, triangleAnimationRight,
                                        triangleAnimationTop]
    triangleAnimationGroup.duration = triangleAnimationTop.beginTime + triangleAnimationTop.duration
    triangleAnimationGroup.fillMode = CAMediaTimingFillMode.forwards
    triangleAnimationGroup.isRemovedOnCompletion = false
    add(triangleAnimationGroup, forKey: nil)
  }

}
