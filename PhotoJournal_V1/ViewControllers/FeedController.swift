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
  
  private var entries = [Entry]()
  private let dataPersistence = PersistenceHelper(filename: "images.plist")
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    loadEntries()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    loadEntries()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "feedCell")
  }
  
  
  private func loadEntries() {
    do {
      entries = try dataPersistence.loadEntries()
      collectionView.reloadData()
      print("Entries count = \(entries.count)")
    } catch {
      print("failed to load enties")
    }
  }
  
  @IBAction func newEntryButtonPressed(_ sender: UIBarButtonItem) {
    let newSB = UIStoryboard(name: "Main", bundle: nil)
    
    let newEntryVC = newSB.instantiateViewController(identifier: "NewEntryViewController", creator: { (coder) in
      return NewEntryViewController(coder: coder, image: nil)
    })
    
    newEntryVC.modalPresentationStyle = .fullScreen
    present(newEntryVC, animated: true)
    
  }
  
  
  
  @IBAction func settingButtonPressed(_ sender: UIBarButtonItem) {
    
    let newSB = UIStoryboard(name: "Main", bundle: nil)
    
    guard let settingVC = newSB.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
      fatalError("failed to downcast NewEntryViewController")
      
    }
    //    settingVC.modalPresentationStyle = .fullScreen
    
    present(settingVC, animated: true)
    
  }
  
  
}

extension FeedController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return entries.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
      fatalError("unable to downcat feedCell")
    }
    
    let entry = entries[indexPath.row]
//    cell.entryCommentLabel.text = entry.indentifier
    cell.configureCell(entry)
    cell.delegate = self
    return cell
  }
  
  
}

extension FeedController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxWidth: CGFloat = UIScreen.main.bounds.size.width
    let itemWidth: CGFloat = maxWidth * 0.80
    return CGSize(width: itemWidth, height: itemWidth)
  }
}

extension FeedController: FeedCellDelegate {
  func editButtonPressed(_ feedCell: FeedCell) {
    print("editButtonPressed = delegate connected")
    
    guard let indexPath = collectionView.indexPath(for: feedCell) else {
      return
    }
    
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (alertAction) in
      print("delete Pressed")
      self.deleteEntry(indexPath: indexPath)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
    
  }
    private func deleteEntry(indexPath: IndexPath) {
      
      do {
        try dataPersistence.deleteEntry(indexPath.row)
      } catch {
        print("Deleting Error: \(error)")
      }
      entries.remove(at: indexPath.row)
      collectionView.deleteItems(at: [indexPath])
    }
    
  
  
}

