//
//  NewEntryViewController.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController {

  @IBOutlet weak var newEntryImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  
  private let imagePickerController = UIImagePickerController()
  
  private let dataPersistence = PersistenceHelper(filename: "images.plist")
  
  private var selectedImage: UIImage? {
    didSet {
      print("new image selected")
      newEntryImageView.image = selectedImage
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    setUpCamera()
    imagePickerController.delegate = self
    }
  
  private func setUpCamera() {
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
      cameraButton.isEnabled = false
    }
  }
    
  @IBAction func cancellButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
  }
  
  @IBAction func phtotoLibraryButton(_ sender: UIBarButtonItem) {
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true)
  }
  
  @IBAction func cameraButton(_ sender: UIBarButtonItem) {
    imagePickerController.sourceType = .camera
    present(imagePickerController, animated: true)
  }
  
  
  
  
}


extension NewEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    imagePickerController.dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      print("image selected not found")
      return
    }
    print("image selected")
    selectedImage = image
    imagePickerController.dismiss(animated: true)
  }
}
