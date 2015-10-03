//
//  ImageFunctions.swift
//

import Foundation
import UIKit

public class ImageFunctions {
  
  public class func fixOrientation(img: UIImage) -> UIImage {
    if img.imageOrientation == .Up {
      return img;
    }
    
    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
    let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
    img.drawInRect(rect)
    
    var normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return normalizedImage
  }
  
  // Rotates image 90 degrees
  public class func rotateImage(img: UIImage) -> UIImage {
    
    var transform: CGAffineTransform = CGAffineTransformIdentity
    transform = CGAffineTransformTranslate(transform, 0, img.size.height)
    transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
    
    var ctx = CGBitmapContextCreate(nil, Int(img.size.height), Int(img.size.width), CGImageGetBitsPerComponent(img.CGImage), 0, CGImageGetColorSpace(img.CGImage), CGImageGetBitmapInfo(img.CGImage))
    CGContextConcatCTM(ctx, transform)
    CGContextDrawImage(ctx, CGRectMake(0, 0, img.size.height, img.size.width), img.CGImage)
    var cgimg = CGBitmapContextCreateImage(ctx)
    var image = UIImage(CGImage: cgimg)
    
    return image!
  }
  
  // Resizes image
  public class func imageResize(originalImage: UIImage) -> UIImage {
    let contextImage: UIImage = originalImage
    let contextSize: CGSize = contextImage.size
    
    let posX: CGFloat
    let posY: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    // Check to see which length is the longest and create the offset based on that length, then set the width and height of our rect
    if contextSize.width > contextSize.height {
      posX = ((contextSize.width - contextSize.height) / 2)
      posY = 0
      width = contextSize.height
      height = contextSize.height
    } else {
      posX = 0
      posY = ((contextSize.height - contextSize.width) / 2)
      width = contextSize.width
      height = contextSize.width
    }
    
    let rect: CGRect = CGRectMake(posX, posY, width, height)
    
    // Create bitmap image from context using the rect
    let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)
    
    // Create a new image based on the imageRef and rotate back to the original orientation
    let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)!
    
    return image
  }
  
}