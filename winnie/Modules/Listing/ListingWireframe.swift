//
//  ListingWireframe.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import UIKit

class ListingWireframe: NSObject {
  
  // Storyboard
  let ListingStoryboard = "Listing"
  // Individual Storyboard IDs
  let AddListingViewControllerIdentifier = "AddListing"
  
  // Wireframes
  var rootWireframe: RootWireframe!
  var cameraWireframe: CameraWireframe!
  
  // View Controllers
  var navigationController: UINavigationController?
  var addListingViewController: AddListingViewController?
  var homeListViewController: HomeListViewController?
  
  // MISC
  var presenter: ListingPresenter!
  var cameraPresenter: CameraPresenter!
  
  func listingStoryboard() -> UIStoryboard {
    let storyboard = UIStoryboard(name: ListingStoryboard, bundle: NSBundle.mainBundle())
    return storyboard
  }
  
  func presentAddListing(viewController: UIViewController, thumbnail: UIImage? = nil, animated: Bool? = true) {
    let addListingVC = addListingViewControllerFromStoryboard()
    addListingVC.presenter = presenter
    addListingViewController = addListingVC
    presenter.addListingViewController = addListingViewController
    cameraPresenter.addListingViewController = addListingViewController
    if let thumbnail = thumbnail {
      addListingViewController!.thumbnails.append(thumbnail)
    }
    rootWireframe.pushViewController(addListingVC, animated: animated)
  }
  
  func addListingViewControllerFromStoryboard() -> AddListingViewController {
    let storyboard = listingStoryboard()
    let addListingViewController = storyboard.instantiateViewControllerWithIdentifier(AddListingViewControllerIdentifier) as! AddListingViewController
    return addListingViewController
  }
  
  func dismissListing(animated: Bool? = true) {
    rootWireframe.popViewController(animated: animated!)
  }
  
  func presentCameraInterface() {
    cameraWireframe.presentCamera(addListingViewController!)
  }
}