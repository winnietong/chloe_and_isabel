//
//  TransitionManager.swift
//  winnie
//
//  Created by Winnie Tong on 10/7/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
  
  var presenting: Bool = true
  
  // MARK: UIViewControllerAnimatedTransitioning protocol methods
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    // Animations to take place within the containerView specified by the context
    let container = transitionContext.containerView()
    
    // Get our to and from view controllers
    let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
    let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
    
    // There are a number of 2D transforms we can make. Here are just a few:
    let onScreenBottom = CGAffineTransformMakeTranslation(0, container.frame.height)
    let tuckAnimation = CGAffineTransformMakeScale(0.90, 0.90)
    let untuckAnimation = CGAffineTransformMakeScale(1, 1)
    
    // Set the toView to prepare for animation
    toView.view.transform = self.presenting ? onScreenBottom : tuckAnimation
    
    // Add our views to the container
    container.addSubview(fromView.view)
    container.addSubview(toView.view)
    
    // Keep the fromView in front if we're dismissing the VC
    if !self.presenting {
      container.bringSubviewToFront(fromView.view)
    }
    
    container.setNeedsLayout()
    container.layoutIfNeeded()
    
    // Play the animation
    UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut, animations: {
      fromView.view.transform = self.presenting ? tuckAnimation : onScreenBottom
      toView.view.transform = self.presenting ? CGAffineTransformIdentity : untuckAnimation
      }, completion: { finished in
        // Tell our context object that animation is complete
        transitionContext.completeTransition(true)
    })
    
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.5
  }
  
  // MARK: UIViewControllerTransitioningDelegate protocol methods
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = false
    return self
  }
  
}