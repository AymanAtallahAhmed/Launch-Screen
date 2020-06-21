//
//  HolderView.swift
//  Launch Screen
//
//  Created by Ayman Ata on 6/15/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
  func animateLabel()
}

class HolderView: UIView {

    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()

    
  var parentFrame :CGRect = CGRect()
  weak var delegate:HolderViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
  }
  
    required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
    
    func addOval() {
      layer.addSublayer(ovalLayer)
      ovalLayer.expand()
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(wobbleOval),
        userInfo: nil, repeats: false)

    }
    

    @objc func wobbleOval() {
        layer.addSublayer(triangleLayer)
        ovalLayer.wobble()
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(drawAnimatedTriangle), userInfo: nil, repeats: false)
    }

    @objc func drawAnimatedTriangle() {
      triangleLayer.animate()
        
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector (spinAndTransform) ,
        userInfo: nil, repeats: false)

    }

    
    @objc func spinAndTransform() {
      // 1
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.6)
      // 2
      let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
      rotationAnimation.toValue = CGFloat(Double.pi * 2.0)
      rotationAnimation.duration = 0.45
        rotationAnimation.isRemovedOnCompletion = true
        layer.add(rotationAnimation, forKey: nil)

      // 3
      ovalLayer.contract()
        
        Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(drawRedAnimatedRectangle), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 0.65, target: self, selector: #selector(drawBlueAnimatedRectangle), userInfo: nil, repeats: false)

    }
    
    
    @objc func drawRedAnimatedRectangle() {
      layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(color: .red)
    }
      
    
    @objc func drawBlueAnimatedRectangle() {
      layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.animateStrokeWithColor(color: .blue)
        
        Timer.scheduledTimer(timeInterval: 0.40, target: self, selector: #selector(drawArc),
        userInfo: nil, repeats: false)
    }
    
    
    @objc func drawArc() {
      layer.addSublayer(arcLayer)
      arcLayer.animate()
        
        Timer.scheduledTimer(timeInterval: 0.90, target: self, selector: #selector(expandView),
        userInfo: nil, repeats: false)

    }
    
    @objc func expandView() {
      // 1
      backgroundColor = .cyan

      // 2
        frame = CGRect(x: frame.origin.x - blueRectangleLayer.lineWidth,
                       y: frame.origin.y - blueRectangleLayer.lineWidth,
                       width: frame.size.width + blueRectangleLayer.lineWidth * 2,
                       height: frame.size.height + blueRectangleLayer.lineWidth * 2)
        
      // 3
      layer.sublayers = nil
      
      // 4
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],
        animations: {
          self.frame = self.parentFrame
        }, completion: { finished in
          self.addLabel()
        })
    }

    
    func addLabel() {
      delegate?.animateLabel()
    }

}

