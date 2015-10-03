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
  
  func presentToNavigationController(viewController: UIViewController) {
    navigationController.presentViewController(viewController, animated: true, completion: nil)
  }
  
  func popToRootViewControllerAnimated(animated: Bool? = false) {
    navigationController.popToRootViewControllerAnimated(animated!)
  }
  
//  func dismissViewControllerWithTransition(viewController: UIViewController, isPresenting: Bool? = false) {
//    let transitionManager = TransitionManager()
//    transitionManager.presenting = isPresenting!
//    if let navController = viewController.navigationController {
//      navController.transitioningDelegate = transitionManager
//      navController.dismissViewControllerAnimated(true, completion: nil)
//    }
//  }
}
