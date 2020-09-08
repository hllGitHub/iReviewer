//
//  HomeViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit
import CVCalendar
import PureLayout
import AFDateHelper

class HomeViewController: UIViewController {
  private var menuView: CVCalendarMenuView = {
    let menuView = CVCalendarMenuView()
    menuView.translatesAutoresizingMaskIntoConstraints = false
    return menuView
  }()
  private var calendarView: CVCalendarView = {
    let calendarView = CVCalendarView()
    calendarView.translatesAutoresizingMaskIntoConstraints = false
    return calendarView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = R.string.root.tabHomeTitle()

    // Configure navigationItem
    configureNavigationItem()

    // Setup UI
    setupUI()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    menuView.commitMenuViewUpdate()
    calendarView.commitCalendarViewUpdate()
  }

  func setupUI() {
    menuView.menuViewDelegate = self
    calendarView.calendarDelegate = self
    calendarView.calendarAppearanceDelegate = self
    calendarView.toggleCurrentDayView()

    // Initial navTitle
    showNavTitle(from: calendarView.presentedDate)

    view.addSubview(menuView)
    view.addSubview(calendarView)

    // Auto layout
    menuView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    menuView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    menuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
    menuView.heightAnchor.constraint(equalToConstant: 15).isActive = true

    calendarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    calendarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    calendarView.topAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
    calendarView.heightAnchor.constraint(equalToConstant: 320).isActive = true
  }

  func configureNavigationItem() {
    // Add leftBarButtonItem for selecting today.
    let leftBarButtonItem = UIBarButtonItem(title: "Today", style: .done, target: self, action: #selector(selectToday))
    self.navigationItem.leftBarButtonItem = leftBarButtonItem

    // Add rightBarButtonItem for adding todo.
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
    self.navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  private func showNavTitle(from date: CVDate) {
    guard let currentDate = date.convertedDate() else {
      return
    }
    let shortMonth = currentDate.toString(style: .shortMonth)
    let dateTitle = shortMonth + "," + currentDate.toString(format: .isoYear)
    navigationItem.title = dateTitle
  }

  @objc func addTodo() {
    self.navigationController?.pushViewController(AddTodoViewController(), animated: true)
  }

  @objc func selectToday() {
    calendarView.toggleCurrentDayView()
  }
}

extension HomeViewController: MenuViewDelegate {
  func dayOfWeekFont() -> UIFont {
    return .h3
  }

  func dayOfWeekTextColor() -> UIColor {
    return .orange
  }
}

extension HomeViewController: CVCalendarViewDelegate {
  func presentationMode() -> CalendarMode {
    return .monthView
  }

  func firstWeekday() -> Weekday {
    return .sunday
  }

  func shouldShowWeekdaysOut() -> Bool {
    return true
  }

  func shouldAutoSelectDayOnWeekChange() -> Bool {
    return true
  }

  func shouldSelectRange() -> Bool {
    return false
  }

  func presentedDateUpdated(_ date: CVDate) {
    showNavTitle(from: date)
  }
}

extension HomeViewController: CVCalendarViewAppearanceDelegate {
  func dayLabelWeekdayFont() -> UIFont {
    return .h3
  }

  func dayLabelPresentWeekdayBoldFont() -> UIFont {
    return .body1
  }
}
