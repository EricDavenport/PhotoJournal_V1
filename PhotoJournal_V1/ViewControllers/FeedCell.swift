//
//  FeedCell.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

protocol FeedCellDelegaste: AnyObject {
  func editButtonPressed(_ feedCell: FeedCell)
}

class FeedCell: UICollectionViewCell {
  
  public var entry: Entry!
  
  @IBOutlet weak var entryImageView: UIImageView!
  
  @IBOutlet weak var entryCommentLabel: UILabel!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 20.0
    
  }
  
  @IBAction func editButtonPressed(_ sender: UIButton) {
    
    openEditScreen()
    
  }
  
  private func openEditScreen() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
    guard let newEntryVC = sb.instantiateViewController(withIdentifier: "NewEntryViewController") as? NewEntryViewController else {
      fatalError("failed to downcast NewEntryViewController")
      
    }
    guard let image = UIImage(data: entry.imageData) else {
      print("no image data")
      return
    }
    
//    newEntryVC.selectedImage = image
//    newEntryVC.
    newEntryVC.modalPresentationStyle = .fullScreen
    self.window?.rootViewController?.present(newEntryVC, animated: true)
    
  }
  
  public func configureCell(_ entry: Entry) {
    guard let image = UIImage(data: entry.imageData) else {
      return
    }
    //    entryImageView.contentMode = .scaleAspectFit
    entryImageView.image = image
    entryCommentLabel.text = entry.indentifier
  }
  
  
  
  
  
}
