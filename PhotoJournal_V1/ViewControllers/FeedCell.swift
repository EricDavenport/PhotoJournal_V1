//
//  FeedCell.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
  func editButtonPressed(_ feedCell: FeedCell)
}

class FeedCell: UICollectionViewCell {
  
  public var entry: Entry?
  
  @IBOutlet weak var entryImageView: UIImageView!
  
  @IBOutlet weak var entryCommentLabel: UILabel!
  
  weak var delegate: FeedCellDelegate?
  
//  init?(coder: NSCoder, entry: Entry) {
//    self.entry = entry
//    super.init(coder: coder)
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 40.0
    
  }
  
  @IBAction func editButtonPressed(_ sender: UIButton) {
    delegate?.editButtonPressed(self)
//    openEditScreen()
    
  }
  
  private func openEditScreen() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
//        guard let image = UIImage(data: entry.imageData) else {
//      print("no image data")
//      return
//    }

    let editVC = sb.instantiateViewController(identifier: "NewEntryViewController", creator: { (coder) in
      return NewEntryViewController(coder: coder, image: nil)
    })
    
    
//    newEntryVC.selectedImage = image
//    newEntryVC.
    editVC.modalPresentationStyle = .fullScreen
    self.window?.rootViewController?.present(editVC, animated: true)
    
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
