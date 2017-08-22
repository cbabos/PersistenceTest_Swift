//
//  PersistedData.swift
//  Persistence
//
//  Created by Csaba Babos on 2017. 08. 22..
//  Copyright © 2017. Csaba Babos. All rights reserved.
//

import Foundation
import os.log

class PersistedData: NSObject, NSCoding {
  public var date: Date
  private var text: String
  
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("persistedData")
  
  override init() {
    self.text = ""
    self.date = Date()
    super.init()
  }
  
  init(text: String, date: Date) {
    self.text = text
    self.date = date
  }
  
  func setStored(text: String) {
    self.text = text;
    self.date = Date();
  }
  
  func getStored() -> String {
    os_log("Saved at: %s", date.description)
    return text
  }
  
  //MARK: NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "text")
    aCoder.encode(date, forKey: "date")
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard let loadedText = aDecoder.decodeObject(forKey: "text") as? String
      else {
        os_log("Could not decode text")
        return nil
      }
    
    guard let loadedDate = aDecoder.decodeObject(forKey: "date") as? Date
      else {
        os_log("Could not decode text")
        return nil
      }
    
    self.init(text: loadedText, date: loadedDate)
  }
  
}
