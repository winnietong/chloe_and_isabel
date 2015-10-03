//
//  CameraPresenter.swift
//  winnie
//
//  Created by Winnie Tong on 5/28/15.
//

import UIKit

class CameraPresenter: NSObject {
  var interactor: CameraInteractor!
  var wireframe: CameraWireframe!
  
  var cameraViewController: CameraViewController!
  var addListingViewController: AddListingViewController!
  
  // Captures image and adds it to the listing view controller
  func postImageToListing(image: UIImage) {
    func success(result: String) -> Void {
      self.addListingViewController.thumbnails.append(image)
      self.addListingViewController.galleryCollectionView.reloadData()
      self.dismissCamera()
    }
    
    interactor.postListingImage(image, success: success)
  }
  
  func dismissCamera() {
    // If there are no images, then do nothing
    wireframe.dismissCamera(animated: true, toRoot: addListingViewController.thumbnails.count == 0)
  }
}