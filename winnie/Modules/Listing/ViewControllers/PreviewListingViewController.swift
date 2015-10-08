//
//  PreviewListingViewController
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import UIKit

class PreviewListingViewController: UIViewController {
  
  var presenter: ListingPresenter!
  var testTitle: String!
  var testDescription: String!
  
  @IBOutlet weak var myTitle: UILabel!
  @IBOutlet weak var myDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    myTitle.text = testTitle
    myDescription.text = testDescription
  }
  
  @IBAction func shareListingButton(sender: AnyObject) {
    presenter.dismissToRootWithTransition()
  }

}
