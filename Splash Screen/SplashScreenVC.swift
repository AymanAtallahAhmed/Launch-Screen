//
//  ViewController.swift
//  Splash Screen
//
//  Created by Ayman Ata on 6/21/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController, HolderViewDelegate {

    var holderView = HolderView(frame: CGRect())
    
    override func viewDidLoad() {
      super.viewDidLoad()
    }
    
      override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      addHolderView()
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
    
    func addHolderView() {
      let boxSize: CGFloat = 140.0
      holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                y: view.bounds.height / 2 - boxSize / 2,
                                width: boxSize,
                                height: boxSize)
      holderView.parentFrame = view.frame
      holderView.delegate = self
      //holderView.backgroundColor = .black
      
      view.addSubview(holderView)
      holderView.addOval()

    }
    
    func animateLabel() {
      // 1
      holderView.removeFromSuperview()
      view.backgroundColor = .systemTeal

      // 2
      let label: UILabel = UILabel(frame: view.frame)
      label.textColor = .white
      label.font = UIFont(name: "HelveticaNeue-Thin", size: 170.0)
      label.textAlignment = NSTextAlignment.center
      label.text = "M"
      label.transform = label.transform.scaledBy(x: 0.25, y: 0.25)
      view.addSubview(label)

      // 3
      UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [],
        animations: ({
          label.transform = label.transform.scaledBy(x: 4.0, y: 4.0)
        }), completion: { finished in
          self.addButton()
        })
      
      let continueLabel: UILabel = {
          let label = UILabel()
          label.textColor = .white
          label.font = UIFont(name: "HelveticaNeue-Thin", size: 40.0)
          label.textAlignment = NSTextAlignment.center
          label.text = "Press To Continue"
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      view.addSubview(continueLabel)
      continueLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
      continueLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
      continueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
      
    }

    
    func addButton() {
      let button = UIButton()
      button.frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
      button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
      view.addSubview(button)
    }
    
      @objc func buttonPressed(sender: UIButton!) {
      view.backgroundColor = .white
      _ = view.subviews.map({ $0.removeFromSuperview() })
      holderView = HolderView(frame: CGRect())
      addHolderView()
    }
}

