//
//  ListingGalleryCollectionViewCell.swift
//

import Foundation
import UIKit

class ListingGalleryCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
  
  var presenter: ListingPresenter!
  var imageIndex: Int?
  var removeImageView: UIButton!
  
  @IBOutlet weak var galleryImageView: UIImageView!
  
  func setGalleryCell(image: UIImage? = nil, index: Int) {
    imageIndex = index
    if let image = image {
      galleryImageView.image = image
      var orientation = galleryImageView.image!.imageOrientation
      addDeleteImageButton()
    }
  }
  
  func setActiveCell() {
    removeAllSubviews(galleryImageView)
    galleryImageView.image = UIImage(named: "gallery-dotted-outline-camera")
  }
  
  func setEmptyCell() {
    removeAllSubviews(galleryImageView)
    galleryImageView.image = UIImage(named: "gallery-dotted-outline.png")
  }
  
  func removeAllSubviews(view: UIView) {
    for subview in view.subviews {
      subview.removeFromSuperview()
    }
  }
  
  func addDeleteImageButton() {
    let removeIcon = UIImage(named: "remove-photo")
    removeImageView = UIButton()
    removeImageView.setImage(removeIcon, forState: .Normal)
    removeImageView.frame = CGRect(x:-4, y:-4, width:20, height:20)
    
    let circleView = UIView(frame: CGRect(x:-5, y:-5, width:22, height:22))
    circleView.layer.cornerRadius = 11;
    circleView.backgroundColor = UIColor.darkGrayColor()
    galleryImageView.addSubview(circleView)
    galleryImageView.addSubview(removeImageView)
    
    // Delete gesture removes image for listing
    var removeImageTap = UITapGestureRecognizer(target: self, action: "removeImageFromListing")
    removeImageTap.delegate = self
    addGestureRecognizer(removeImageTap)
  }
  
  func removeImageFromListing() {
    presenter.removeImageFromListing(imageIndex!)
  }
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    if let removeImageView = removeImageView {
      return removeImageView.frame.contains(touch.locationInView(self))
    }
    return false
  }
  
}