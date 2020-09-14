//
//  HomeViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit
import PureLayout
import AFDateHelper
import JTCalendar

class HomeViewController: UIViewController {
  // JTCalendar
  private var calendarMenuView: JTCalendarMenuView = {
    let menuView = JTCalendarMenuView()
    menuView.translatesAutoresizingMaskIntoConstraints = false
    return menuView
  }()

  private var calendarContentView: JTHorizontalCalendarView = {
    let contentView = JTHorizontalCalendarView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    return contentView
  }()

  private var calendarManager: JTCalendarManager = {
    let manager = JTCalendarManager()
    manager.settings?.pageViewHaveWeekDaysView = true
    return manager
  }()

  private var selectedDate = Date()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = R.string.root.tabHomeTitle()

    // Configure navigationItem
    configureNavigationItem()

    // Setup calendar
    configureCalendar()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  func configureNavigationItem() {
    // Add leftBarButtonItem for selecting today.
    let leftBarButtonItem = UIBarButtonItem(title: "Today", style: .done, target: self, action: #selector(selectToday))
    self.navigationItem.leftBarButtonItem = leftBarButtonItem

    // Add rightBarButtonItem for adding todo.
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
    self.navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  @objc func addTodo() {
    let addTodoViewController = AddTodoViewController()
    addTodoViewController.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(addTodoViewController, animated: true)
  }

  @objc func selectToday() {
    calendarManager.setDate(Date())
  }

  private func configureCalendar() {
    calendarManager.delegate = self

    calendarManager.menuView = calendarMenuView
    calendarManager.contentView = calendarContentView
    calendarManager.setDate(Date())

    view.addSubview(calendarMenuView)
    view.addSubview(calendarContentView)

    // Auto layout
    calendarMenuView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    calendarMenuView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    calendarMenuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
    calendarMenuView.heightAnchor.constraint(equalToConstant: 15).isActive = true

    calendarContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    calendarContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    calendarContentView.topAnchor.constraint(equalTo: calendarMenuView.bottomAnchor).isActive = true
    calendarContentView.heightAnchor.constraint(equalToConstant: 320).isActive = true
  }
}

extension HomeViewController: JTCalendarDelegate {
  func calendar(_ calendar: JTCalendarManager?, prepareDayView dayView: (UIView & JTCalendarDay)?) {
    guard let dayView = dayView as? JTCalendarDayView, let dateHelper = calendarManager.dateHelper else {
      return
    }

    dayView.isHidden = false

    if dayView.isFromAnotherMonth() {
      dayView.isHidden = true
    } else if dateHelper.date(Date(), isTheSameDayThan: dayView.date) {
      dayView.circleView.isHidden = false
      dayView.circleView.backgroundColor = .blue
      dayView.dotView.backgroundColor = .white
      dayView.textLabel.textColor = .white
    } else if dateHelper.date(selectedDate, isTheSameDayThan: dayView.date) {
      dayView.circleView.isHidden = false
      dayView.circleView.backgroundColor = .red
      dayView.dotView.backgroundColor = .white
      dayView.textLabel.textColor = .white
    } else {
      dayView.circleView.isHidden = true
      dayView.dotView.backgroundColor = .red
      dayView.textLabel.textColor = .black
    }

//    dayView.dotView.isHidden = false
  }

  func calendar(_ calendar: JTCalendarManager?, didTouchDayView dayView: (UIView & JTCalendarDay)?) {
    guard let dayView = dayView as? JTCalendarDayView, let dateHelper = calendarManager.dateHelper else {
      return
    }

    // Use to indicate the selected date
    selectedDate = dayView.date

    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.transition(with: dayView, duration: 0.3, options: .allowAnimatedContent, animations: {
      dayView.circleView.transform = CGAffineTransform.identity
      self.calendarManager.reload()
    }, completion: nil)

    // Load the previous or next page if touch a day from another month
    if !dateHelper.date(calendarContentView.date, isTheSameMonthThan: dayView.date) {
      if calendarContentView.date.compare(dayView.date) == .orderedAscending {
        calendarContentView.loadNextPageWithAnimation()
      } else {
        calendarContentView.loadPreviousPageWithAnimation()
      }
    }
  }

  func calendarBuildDayView(_ calendar: JTCalendarManager?) -> (UIView & JTCalendarDay)? {
    let view = JTCalendarDayView()
    view.textLabel.font = .customYuantiRegularFont(ofSize: 14)
    view.textLabel.textColor = .black
    view.dotView.backgroundColor = .red
    return view
  }
}
