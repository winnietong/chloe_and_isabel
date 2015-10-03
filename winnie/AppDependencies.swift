//
//  AppDependencies.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
  
  // Wireframes
  var homeWireframe = HomeWireframe()
  var listingWireframe = ListingWireframe()
  var cameraWireframe = CameraWireframe()
  
  init() {
    configureDependencies()
  }
  
  func installViewControllersIntoWindow(window: UIWindow) {
    // Initialize the root view controller
      homeWireframe.presentListInterfaceFromWindow(window)
  }
  
  func configureDependencies() {
    let rootWireframe = RootWireframe()
    
    // MARK: - Home Module
    let homePresenter = HomePresenter()
    let homeInteractor = HomeInteractor()
    
    homeInteractor.presenter = homePresenter
    homePresenter.interactor = homeInteractor
    homePresenter.wireframe = homeWireframe
    
    // Instantiate wireframes
    homeWireframe.presenter = homePresenter
    homeWireframe.rootWireframe = rootWireframe
    
    // MARK: - Listing Module
    let listingPresenter = ListingPresenter()
    let listingInteractor = ListingInteractor()
    
    listingInteractor.presenter = listingPresenter
    listingPresenter.interactor = listingInteractor
    listingPresenter.wireframe = listingWireframe
    
    listingWireframe.presenter = listingPresenter
    listingWireframe.rootWireframe = rootWireframe
    listingWireframe.cameraWireframe = cameraWireframe
    
    // MARK: - Camera Module
    let cameraPresenter = CameraPresenter()
    let cameraInteractor = CameraInteractor()
    
    cameraWireframe.presenter = cameraPresenter
    cameraWireframe.listingWireframe = listingWireframe
    cameraPresenter.interactor = cameraInteractor
    cameraPresenter.wireframe = cameraWireframe
    
    
    // Wireframe Dependencies
    homeWireframe.listingWireframe = listingWireframe
    homeWireframe.cameraWireframe = cameraWireframe
    
    listingWireframe.cameraPresenter = cameraPresenter

  }
}