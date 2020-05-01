//
//  FileManager+Extension.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

extension FileManager {
  // return a URL to the document directory
  static func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
  // functiont akes a filename as a parameter, appends to the document directory's URL and returns the path
  // this path will be used to write (save the data) data or or read (retrieve) data
  static func pathToDocumentsDirectory(with filename: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent(filename)
  }
}

