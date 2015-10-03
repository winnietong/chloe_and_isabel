//
//  HomeListViewController.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.

import UIKit

class HomeListViewController: UIViewController {
  
  var presenter: HomePresenter!
  
  // Constants
  let screenSize: CGRect = UIScreen.mainScreen().applicationFrame
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.hidden = true
  }
  
  // UI Actions
  @IBAction func listItemButtonClick(sender: AnyObject) {
    presenter.addListingInterface()
  }
  
}

