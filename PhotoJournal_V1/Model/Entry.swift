//
//  Entry.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

struct Entry: Codable {
  let imageData: Data
  let date: Date
  let indentifier = UUID().uuidString
}
