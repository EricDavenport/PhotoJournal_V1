//
//  PersistenceHelper.swift
//  PhotoJournal_V1
//
//  Created by Eric Davenport on 5/1/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error {
  case savingError(Error)
  case fileDoesNotExist(String)
  case noData
  case decodingError(Error)
  case deletingError(Error)
}

class PersistenceHelper {
  
  private var entries = [Entry]()
  
  private var filename: String
  
  init(filename: String) {
    self.filename = filename
  }
  
  private func save() throws {
    // get file url path to save entry
    let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    do {
      let data = try PropertyListEncoder().encode(entries)
      
      try data.write(to: url, options: .atomic)
    } catch {
      throw DataPersistenceError.savingError(error)
    }
  }
  
  public func createEntry(_ entry: Entry) throws {
    entries.append(entry)
    
    do {
      try save()
    } catch {
      throw DataPersistenceError.savingError(error)
    }
  }
  
  public func loadEntries() throws -> [Entry] {
    let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    if FileManager.default.fileExists(atPath: url.path) {
      if let data = FileManager.default.contents(atPath: url.path) {
        do {
          entries = try PropertyListDecoder().decode([Entry].self, from: data)
          print(entries.count)
        } catch {
          throw DataPersistenceError.decodingError(error)
        }
      }
    } else {
      throw DataPersistenceError.noData
    }
    return entries
  }
  
  public func deleteEntry(_ entryIndex: Int) throws {
    entries.remove(at: entryIndex)
    
    do {
      try save()
    } catch {
      throw DataPersistenceError.decodingError(error)
    }
    
  }
  
  public func editEntry(_ entryIndex: IndexPath, caption: String) throws {
    entries[entryIndex.row].caption = caption
    
    do {
      try save()
    } catch {
      throw DataPersistenceError.savingError(error)
    }
  }
  
  
}
