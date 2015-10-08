//
//  AddListingViewController.swift
//  winnie
//
//  Created by Winnie Tong on 10/3/15.
//  Copyright (c) 2015 Winnie Tong. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UITextViewDelegate {
  
  var presenter: ListingPresenter!
  
  var thumbnails: [UIImage!] = []
  var maxImagesInGallery: Int = 5 // Number of images allowed in a gallery
  var galleryCellSize: CGFloat = 100
  var galleryHeight: CGFloat = 0.0
  var initializedTextField: Bool = false
  
  @IBOutlet weak var listPriceLabel: UILabel!
  @IBOutlet weak var galleryCollectionView: UICollectionView!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    navigationController?.navigationBar.hidden = false
    self.navigationItem.setHidesBackButton(true, animated:true)
    
    descriptionTextView.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    configureCollectionView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func shareItemButton(sender: AnyObject) {
    presenter.postListing(titleTextField.text, description: descriptionTextView.text)
  }
  
  func closeButtonClick() {
    presenter.dismissToRootWithTransition()
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    // Clears the placeholder text when they're first inputing a description
    if !initializedTextField {
      descriptionTextView.text = ""
      initializedTextField = true
    }
  }
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    // Pass the touch if we are touching within the gallery view.
    return !(galleryCollectionView.frame.contains(touch.locationInView(self.view)))
  }
  
  func configureCollectionView() {
    galleryCollectionView.dataSource = self
    galleryCollectionView.delegate = self
    let cellNib = UINib(nibName: "ListingGalleryCollectionViewCell", bundle: NSBundle.mainBundle())
    galleryCollectionView.registerNib(cellNib, forCellWithReuseIdentifier: "ListingGalleryCell")
  }
  
  // Mark: - Gallery Collection View
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return maxImagesInGallery
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(galleryCellSize, galleryCellSize)
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = galleryCollectionView.dequeueReusableCellWithReuseIdentifier("ListingGalleryCell", forIndexPath: indexPath) as! ListingGalleryCollectionViewCell
    if indexPath.row < maxImagesInGallery {
      cell.presenter = presenter
      if indexPath.row < thumbnails.count {
        cell.setGalleryCell(image: thumbnails[indexPath.row], index: indexPath.row)
      } else if indexPath.row == thumbnails.count {
        cell.setActiveCell()
      } else {
        cell.setEmptyCell()
      }
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    // Only the first empty cell will bring up the camera module. Clicking any other cell will do nothing.
    if indexPath.row == thumbnails.count {
      presenter.presentCameraInterface()
    }
  }
}
