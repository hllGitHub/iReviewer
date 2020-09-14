//
//  AddTodoViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    title = R.string.root.todoTitle()

    configureNavigationItem()
  }

  func configureNavigationItem() {
    // Add rightBarButtonItem for done.
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    self.navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  @objc func done() {
    Logger.debug("Done. Finish adding todo.", "AddTodo")
  }
}
