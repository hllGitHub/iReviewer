//
//  DiscoverViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
  static let cellId = "cellId"

  private var tableView: UITableView = {
    let tableView = UITableView()
    tableView.showsVerticalScrollIndicator = false
    tableView.register(MenuCell.self, forCellReuseIdentifier: DiscoverViewController.cellId)
    tableView.tableFooterView = UIView()
    return tableView
  }()

  private var menuItems: [MenuItem] = [
    MenuItem(iconImage: R.image.iconSun(), title: R.string.root.menuItemOneDay(), subTitle: nil),
    MenuItem(iconImage: R.image.iconStar(), title: R.string.root.menuItemImportant(), subTitle: nil),
    MenuItem(iconImage: R.image.iconReminder(), title: R.string.root.menuItemPlan(), subTitle: nil),
    MenuItem(iconImage: R.image.iconPerson(), title: R.string.root.menuItemAssign(), subTitle: nil),
    MenuItem(iconImage: R.image.iconTask(), title: R.string.root.menuItemTask(), subTitle: nil)
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    title = R.string.root.tabDiscoverTitle()
    view.backgroundColor = .white

    setupViews()
  }

  private func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)

    tableView.autoPinEdgesToSuperviewEdges()
    tableView.reloadData()
  }
}

extension DiscoverViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverViewController.cellId, for: indexPath) as? MenuCell, indexPath.row < menuItems.count else {
      return UITableViewCell()
    }

    cell.setMenuItem(menuItems[indexPath.row])
    return cell
  }
}

extension DiscoverViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}

struct MenuItem {
  var iconImage: UIImage? // Menu icon

  var title: String       // Menu title

  var subTitle: String?   // Menu subTitle
}
