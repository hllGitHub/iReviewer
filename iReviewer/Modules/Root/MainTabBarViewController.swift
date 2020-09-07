//
//  MainTabBarViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Configure tabBar
    configureTabBar()

    // Setup viewControllers
    setupViewControllers()
  }

  private func configureTabBar() {
    tabBar.tintColor = .tint
    tabBar.backgroundImage = UIImage()
    tabBar.shadowImage = UIImage()
    tabBar.isTranslucent = false
    tabBar.clipsToBounds = true
  }

  private func setupViewControllers() {
    // home
    let homeViewController = configureControllerWrapper(tabBarSystemItem: .bookmarks, viewController: HomeViewController(), itemTag: TabBarItemTag.home)
    // discover
    let discoverViewController = configureControllerWrapper(tabBarSystemItem: .history, viewController: DiscoverViewController(), itemTag: TabBarItemTag.discover)
    // Award
    let awardViewController = configureControllerWrapper(tabBarSystemItem: .topRated, viewController: AwardViewController(), itemTag: TabBarItemTag.award)
    // profile
    let profileViewController = configureControllerWrapper(tabBarSystemItem: .recents, viewController: ProfileViewController(), itemTag: TabBarItemTag.profile)

    viewControllers = [homeViewController, discoverViewController, awardViewController, profileViewController]

    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.customYuantiRegularFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.iGray], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.customYuantiRegularFont(ofSize: 10.0), NSAttributedString.Key.foregroundColor: UIColor.tint], for: .selected)
  }

  private func configureControllerWrapper(title: String, selectedImage: UIImage?, image: UIImage?, viewController: UIViewController, itemTag: TabBarItemTag) -> UIViewController {
    let controllerWrapper = IReviewerNavigationController(rootViewController: viewController)
    controllerWrapper.navigationBar.isTranslucent = false
    controllerWrapper.tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), tag: itemTag.rawValue)
    controllerWrapper.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
    return controllerWrapper
  }

  private func configureControllerWrapper(tabBarSystemItem systemItem: UITabBarItem.SystemItem, viewController: UIViewController, itemTag: TabBarItemTag) -> UIViewController {
    let controllerWrapper = IReviewerNavigationController(rootViewController: viewController)
    controllerWrapper.navigationBar.isTranslucent = false
    controllerWrapper.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: itemTag.rawValue)
    return controllerWrapper
  }
}

enum TabBarItemTag: Int {
  case home
  case discover
  case award
  case profile
}
