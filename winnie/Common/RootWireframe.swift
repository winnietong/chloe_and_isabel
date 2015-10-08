//
//  RootWireframe.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import UIKit

class RootWireframe: NSObject {
  
  var navigationController: UINavigationController!
  
  func showRootViewController(viewController: UIViewController, inWindow: UIWindow) {
    let navigationController = navigationControllerFromWindow(inWindow)
    navigationController.viewControllers = [viewController]
  }
  
  func navigationControllerFromWindow(window: UIWindow) -> UINavigationController {
    navigationController = window.rootViewController as! UINavigationController
    return navigationController
  }
  
  func pushViewController(viewController: UIViewController, animated: Bool? = true) {
    navigationController.pushViewController(viewController, animated: animated!)
  }
  
  func popViewController(animated: Bool? = true) {
    navigationController.popViewControllerAnimated(animated!)
  }
  
  func presentToNavigationController(viewController: UIViewController, animated: Bool? = true) {
    navigationController.presentViewController(viewController, animated: animated!, completion: nil)
  }
  
  func popToRootViewControllerAnimated(animated: Bool? = false) {
    navigationController.popToRootViewControllerAnimated(animated!)
  }
  
  func popToRootViewController(animated: Bool? = true) {
    navigationController.popToRootViewControllerAnimated(animated!)
  }

  // Example of how to use the tranisition manager with navigation controller.
  // Note: Presenting a view controller will not include the navigation controller,
  // so here's a hacky way of getting around it: setting a navController with our toVC
  // and letting the fromVC present it.
  
  // Here's the stack overflow answer that helped me through this:
  // http://stackoverflow.com/questions/25444213/presenting-viewcontroller-with-navigationviewcontroller-swift
  
  func presentWithTransitionManager(toViewController: UIViewController, fromViewController: UIViewController?, presenting: Bool? = true) {
    let transitionManager = TransitionManager()
    transitionManager.presenting = presenting!
    // Get the navigation controller of the passed in viewController
    if (presenting == true) {
      var navController = UINavigationController(rootViewController: toViewController)
      navController.transitioningDelegate = transitionManager
      fromViewController!.presentViewController(navController, animated: true, completion: nil)
    } else {
      var navController = toViewController.navigationController
      navController!.transitioningDelegate = transitionManager
      navController!.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
}
