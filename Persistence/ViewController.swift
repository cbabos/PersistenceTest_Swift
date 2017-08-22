//
//  ViewController.swift
//  Persistence
//
//  Created by Csaba Babos on 2017. 08. 22..
//  Copyright © 2017. Csaba Babos. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {

  @IBOutlet weak var TextInput: UITextField!
  @IBOutlet weak var SavedTextField: UITextView!
  private var persistedData = PersistedData();
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let loadedData = loadPersistedData() {
      persistedData = loadedData;
      setShowedText(to: persistedData.getStored())
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func SaveNewInput(_ sender: Any) {
    let newInput = getNewText();
    setShowedText(to: newInput);
    persistedData.setStored(text: newInput)
    persistData()
  }
  
  func getNewText() -> String {
    var newText = "";
    
    if let returnText = TextInput.text {
      newText = returnText;
    }
    
    return newText;
  }
  
  func setShowedText(to text: String) {
    SavedTextField.text = text + " " + persistedData.date.description;
  }

  //MARK: Persistence 
  private func persistData() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(persistedData, toFile: PersistedData.ArchiveURL.path)
    if isSuccessfulSave {
      os_log("Data successfully saved.", log: .default, type: .debug)
    } else {
      os_log("Failed to save data...", log: .default, type: .error)
    }
  }
  
  private func loadPersistedData() -> PersistedData?  {
    return NSKeyedUnarchiver.unarchiveObject(withFile: PersistedData.ArchiveURL.path) as? PersistedData
  }

}

