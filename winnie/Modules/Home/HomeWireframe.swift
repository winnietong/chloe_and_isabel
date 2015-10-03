//
//  HomeWireframe.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.


import UIKit

class HomeWireframe: NSObject {
  
  // Storyboard
  let HomeStoryboard = "Home"
  let HomeListViewControllerIdentifier = "HomeList"
  
  var presenter: HomePresenter!
  var navigationController: UINavigationController?
  
  // Wireframes
  var rootWireframe: RootWireframe!
  var listingWireframe: ListingWireframe!
  var cameraWireframe: CameraWireframe!

  // Controllers
  var homeListViewController: HomeListViewController?
  var cameraViewController: CameraViewController?

  func homeStoryboard() -> UIStoryboard {
    let storyboard = UIStoryboard(name: HomeStoryboard, bundle: NSBundle.mainBundle())
    return storyboard
  }
  
  func presentListInterfaceFromWindow(window: UIWindow) {
    let homeListVC = listViewControllerFromStoryboard()
    homeListVC.presenter = presenter
    homeListViewController = homeListVC
    presenter.homeListViewController = homeListViewController
    rootWireframe.showRootViewController(homeListVC, inWindow: window)
  }
  
  func listViewControllerFromStoryboard() -> HomeListViewController {
    let storyboard = homeStoryboard()
    let homeListViewController = storyboard.instantiateViewControllerWithIdentifier(HomeListViewControllerIdentifier) as! HomeListViewController
    return homeListViewController
  }
  
  // Presents the Add Listing Interface
  func presentAddListingInterface() {
    // Pushes Listing View Controller without Animation
    // Presents camera wireframe
    listingWireframe.presentAddListing(homeListViewController!, animated: false)
    presentCameraInterface()
  }
  
  // Presents the iPhone Camera view
  func presentCameraInterface() {
    cameraWireframe.presentCamera(homeListViewController!)
  }

}
