//
//  AddListingViewController.swift
//  winnie
//
//  Created by Winnie Tong on 5/21/15.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - Properties
  var presenter: CameraPresenter!
  
  let imageController = UIImagePickerController()
  var captureSession: AVCaptureSession!
  var stillImageOutput: AVCaptureStillImageOutput!
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  // Constants
  let screenWidth: CGFloat = UIScreen.mainScreen().applicationFrame.width
  
  // MARK: - UI Elements
  @IBOutlet weak var imagePreviewView: UIView!
  @IBOutlet weak var capturedImage: UIImageView!
  
  // MARK: - View Setup Functions
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.hidden = true
    configureCamera()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func closeButtonClick(sender: AnyObject) {
    presenter.dismissCamera()
  }
  
  // When a user chooses an image from a gallery
  @IBAction func galleryButtonClick(sender: AnyObject) {
    // opens up photo library
    imageController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    presentViewController(imageController, animated: true, completion: nil)
  }
  
  // When a user chooses to take their own photo
  @IBAction func cameraButtonClick(sender: AnyObject) {
    if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo) {
      videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
      stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
        if let sampleBuffer = sampleBuffer {
          var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
          var dataProvider = CGDataProviderCreateWithCFData(imageData)
          var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault)
          var image = UIImage(CGImage: cgImageRef)
          
          self.captureSession.stopRunning()
          // Crop and rotate the image before posting.
          var croppedImage = ImageFunctions.imageResize(image!)
          self.postImage(ImageFunctions.rotateImage(croppedImage))
        }
      })
    }
  }
  
  func configureCamera() {
    captureSession = AVCaptureSession()
    stillImageOutput = AVCaptureStillImageOutput()
    
    imageController.allowsEditing = true
    imageController.delegate = self
    
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    
    var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    var error: NSError?
    var input = AVCaptureDeviceInput(device: backCamera, error: &error)
    
    captureSession.addInput(input)
    stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
    
    if captureSession.canAddOutput(stillImageOutput) {
      captureSession.addOutput(stillImageOutput)
      
      previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
      imagePreviewView.layer.addSublayer(previewLayer)
      
      captureSession.startRunning()
      previewLayer.frame = CGRectMake(0, 0, screenWidth, screenWidth)
    }
  }

  // MARK: - API Calls
  func postImage(image: UIImage) {
    presenter.postImageToListing(image)
  }
  
  // MARK: - Image Delegates
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    dismissViewControllerAnimated(true) { () -> Void in
      self.captureSession.stopRunning()
      self.postImage(image)
    }
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}