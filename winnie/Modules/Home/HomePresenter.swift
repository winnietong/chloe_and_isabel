//
//  HomePresenter.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.


import UIKit

class HomePresenter: NSObject {
  
  var wireframe: HomeWireframe!
  var interactor: HomeInteractor!
  
  // View Controllers
  var homeListViewController: HomeListViewController?
  
  func addListingInterface() {
    wireframe.presentAddListingInterface()
  }

}
