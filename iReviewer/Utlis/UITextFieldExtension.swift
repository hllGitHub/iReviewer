//
//  UITextFieldExtension.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UITextField {
  func setInputViewDatePicker(target: Any, selector: Selector) {
    // Create a UIDatePicker object and assign to inputView
    let screenWidth = UIScreen.main.bounds.width
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
    datePicker.datePickerMode = .date
    self.inputView = datePicker

    // Create a toolbar and assign it to inputAccessoryView
    let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
    let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
    let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    toolBar.setItems([cancel, flexible, barButton], animated: false)
    self.inputAccessoryView = toolBar
  }

  @objc func tapCancel() {
    self.resignFirstResponder()
  }
}
