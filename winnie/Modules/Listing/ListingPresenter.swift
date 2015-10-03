//
//  ListingPresenter.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import UIKit

class ListingPresenter: NSObject {
  
  var wireframe: ListingWireframe!
  var interactor: ListingInteractor!
  
  var addListingViewController: AddListingViewController!

  func dismissViewController() {
    wireframe.dismissListing()
  }
  
  func presentCameraInterface() {
    wireframe.presentCameraInterface()
  }
  
  func removeImageFromListing(index: Int) {
    addListingViewController?.thumbnails.removeAtIndex(index)
    addListingViewController?.galleryCollectionView.reloadData()
  }
}
