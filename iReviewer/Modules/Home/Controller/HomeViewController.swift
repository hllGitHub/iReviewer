//
//  HomeViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = R.string.root.tabHomeTitle()

    configureNavigationItem()
  }

  func configureNavigationItem() {
    self.navigationItem.title = R.string.root.tabHomeTitle()

    // Add rightBarButtonItem for add todo.
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
    self.navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  @objc func addTodo() {
    self.navigationController?.pushViewController(AddTodoViewController(), animated: true)
  }
}
