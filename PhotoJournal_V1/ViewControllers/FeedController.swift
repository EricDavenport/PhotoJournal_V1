//
//  ViewController.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func newEntryButtonPressed(_ sender: UIBarButtonItem) {
    let newSB = UIStoryboard(name: "Main", bundle: nil)
    
    guard let newEntryVC = newSB.instantiateViewController(withIdentifier: "NewEntryViewController") as? NewEntryViewController else {
      fatalError("failed to downcast NewEntryViewController")
      
    }
    
    present(newEntryVC, animated: true)
    
  }
  
  
  
  @IBAction func settingButtonPressed(_ sender: UIBarButtonItem) {
    
    let newSB = UIStoryboard(name: "Main", bundle: nil)
    
    guard let settingVC = newSB.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
      fatalError("failed to downcast NewEntryViewController")
      
    }
    
    present(settingVC, animated: true)
    
  }
  
  private func presentViewController(_ viewControlerName: String) {
    
  }
  
}

