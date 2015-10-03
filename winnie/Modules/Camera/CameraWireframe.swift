//
//  CameraWireframe.swift
//  winnie
//
//  Created by Winnie Tong on 5/28/15.
//

import UIKit

class CameraWireframe: NSObject {
  
  var CameraViewControllerIdentifier = "CameraViewController"
  
  var rootWireframe: RootWireframe!
  var listingWireframe: ListingWireframe!
  var presenter: CameraPresenter!
  
  var cameraViewController: CameraViewController?
  
  func cameraStoryboard() -> UIStoryboard {
    let storyboard = UIStoryboard(name: "Camera", bundle: NSBundle.mainBundle())
    return storyboard
  }
  
  func getCameraViewControllerFromStoryboard() -> CameraViewController {
    let storyboard = cameraStoryboard()
    let cameraViewController = storyboard.instantiateViewControllerWithIdentifier(CameraViewControllerIdentifier) as! CameraViewController
    return cameraViewController
  }
  
  func presentCamera(viewController: UIViewController) {
    let cameraVC = getCameraViewControllerFromStoryboard()
    cameraVC.presenter = presenter
    cameraViewController = cameraVC
    presenter.cameraViewController = cameraViewController
    var navController = UINavigationController(rootViewController: cameraVC)
    viewController.presentViewController(navController, animated: true, completion: nil)
  }
  
  // TODO: Dismisses camera either to root or just dismisses it. 
  func dismissCamera(animated: Bool? = true, toRoot: Bool? = false) {
    cameraViewController?.navigationController?.dismissViewControllerAnimated(animated!, completion: nil)
    if toRoot! {
      listingWireframe.dismissListing(animated: false)
    }
  }
}