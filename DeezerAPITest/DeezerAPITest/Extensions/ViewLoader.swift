//
//  ViewLoader.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import UIKit

internal class ViewLoader: UIView {
  /// Constants
  private let gradientWidth: CGFloat = 0.2
  private let gradientStop: CGFloat = 0.2
    private let backGrayColor = UIColor.background
    private let firstLoadColor = UIColor.darkGray
  private var gradientAnimationDuration: TimeInterval = 1.0
  private var gradientLayer: CAGradientLayer!

  override init(frame: CGRect) {
    super.init(frame: frame)
    gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.colors = [backGrayColor.cgColor, firstLoadColor.cgColor, backGrayColor.cgColor]
    gradientLayer.locations = [0, 0, 0]

    gradientLayer.cornerRadius = 5
    gradientLayer.frame = frame
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setFrameForGradientLayer(frame: CGRect) {
    gradientLayer.frame = frame
  }

  func setCustom(colors: [UIColor], gradientAnimationDuration: TimeInterval) {
//    if colors.count != 5 {
//      assertionFailure("You should send 5 colors in colors array")
//    }
    var cgColors = [CGColor]()
    colors.forEach({ cgColors.append($0.cgColor) })
    self.gradientLayer.colors = cgColors
    self.gradientAnimationDuration = gradientAnimationDuration
  }

  func startAnimateLayer() {
    let gradientAnimation = CABasicAnimation(keyPath: "locations")
    gradientAnimation.fromValue = gradientLayer.locations
    gradientAnimation.toValue = [1, 2, 1.2]
    
//    gradientAnimation.fromValue = -frame.size.width
//    gradientAnimation.toValue   = frame.size.width
    
    gradientAnimation.duration = gradientAnimationDuration
    gradientAnimation.fillMode = .forwards
    gradientAnimation.repeatCount = .infinity
    gradientLayer.add(gradientAnimation, forKey: nil)
  }

  func stopAnimateLayer() {
    gradientLayer.removeAllAnimations()
  }
}

//import ObjectiveC
private var associationKey = "view_loader_key"

// MARK: - ViewLoader
internal extension UIView {
  var viewLoader: ViewLoader? {
    get {
      return objc_getAssociatedObject(self, &associationKey) as? ViewLoader
    }
    set {
      objc_setAssociatedObject(self, &associationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
}

// MARK: - Internal methods
extension UIView {
  func _showLoader() {
    guard let loader = viewLoader else { return }

    addSubview(loader)
    loader.startAnimateLayer()
  }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap {$0.subviewsRecursive()}
    }
}

extension UIView {
    func showLoader() {
      if viewLoader != nil { return }
      viewLoader = ViewLoader(frame: self.bounds)
      _showLoader()
    }

    func showLoader(colors: [UIColor], animationDuration: TimeInterval = 1.0) {
      if viewLoader != nil { return }
      viewLoader = ViewLoader(frame: self.bounds)
      viewLoader?.setCustom(colors: colors, gradientAnimationDuration: animationDuration)
      _showLoader()
    }

    func hideLoader() {
      viewLoader?.stopAnimateLayer()
      viewLoader?.removeFromSuperview()
      self.viewLoader = nil
    }
}
