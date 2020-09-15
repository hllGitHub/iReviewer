//
//  AddTodoViewController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit
import AFDateHelper

class AddTodoViewController: UIViewController {

  private var bgImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = R.image.scene1()
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  private var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = R.string.root.menuItemOneDay()
    label.font = .h2
    return label
  }()

  private var dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white

    let date = Date()
    label.text = date.toString(format: .custom("M月dd日 ")) + date.weekDayString
    label.font = .body1
    return label
  }()

  private var addTaskView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(hexString: "#B69C94").withAlphaComponent(0.7)
    view.layer.cornerRadius = 6
    view.isUserInteractionEnabled = false
    return view
  }()

  private var addImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = R.image.iconAdd()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private var addTextField: UITextField = {
    let textField = UITextField()
    textField.text = R.string.root.todoAdd()
    textField.font = .body2
    textField.textColor = .white
    return textField
  }()

  private lazy var taskInputView: InputView = {
    let view = InputView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    configureNavigationItem()
    setupViews()
    observerKeyboard()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.navigationBar.setTranslucent(true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    self.navigationController?.navigationBar.setTranslucent(false)
  }

  func observerKeyboard() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillShow(_ notification: Notification) {
    guard let userInfo = notification.userInfo else {
      return
    }

    guard let frame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect, let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? CGFloat else {
      return
    }

    let originFrame = addTaskView.frame
    var destinationFrame = originFrame
    let frameY = frame.origin.y - addTaskView.frame.size.height
    UIView.animate(withDuration: TimeInterval(duration)) {
      destinationFrame.origin.y = frameY
      self.addTaskView.frame = destinationFrame
    }
  }

  @objc func keyboardWillHide(_ notification: Notification) {
    guard let userInfo = notification.userInfo else {
      return
    }

    guard let frame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect, let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? CGFloat else {
      return
    }

    let originFrame = addTaskView.frame
    var destinationFrame = originFrame
    let frameY = frame.origin.y - addTaskView.frame.size.height
    UIView.animate(withDuration: TimeInterval(duration)) {
      destinationFrame.origin.y = frameY
      self.addTaskView.frame = destinationFrame
    }
  }

  func configureNavigationItem() {
    // Add rightBarButtonItem for done.
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    self.navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  func setupViews() {
    taskInputView = InputView(frame: CGRect(x: 0, y: 0, width: UIScreen
      .main.bounds.width, height: 60))
    addTextField.inputAccessoryView = taskInputView

    let tapGes = UITapGestureRecognizer(target: self, action: #selector(add))
    bgImageView.addGestureRecognizer(tapGes)

    view.addSubview(bgImageView)
    view.addSubview(titleLabel)
    view.addSubview(dateLabel)
    view.addSubview(addTaskView)
    addTaskView.addSubview(addImageView)
    addTaskView.addSubview(addTextField)

    // AutoLayout
    bgImageView.autoPinEdgesToSuperviewEdges()
    titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
    dateLabel.autoPinEdge(.left, to: .left, of: titleLabel)
    dateLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 6)

    addTaskView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
    addTaskView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
    addTaskView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
    addTaskView.autoSetDimension(.height, toSize: 50)

    addImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    addImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
    addImageView.autoSetDimensions(to: CGSize(width: 28, height: 28))

    addTextField.autoPinEdge(.left, to: .right, of: addImageView, withOffset: 16)
    addTextField.autoAlignAxis(toSuperviewAxis: .horizontal)
    addTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
  }

  @objc func done() {
    Logger.debug("Done. Finish adding todo.", "AddTodo")

    guard let text = taskInputView.inputText, text.count > 0 else {
      return
    }

    Logger.debug("InputText: \(text). Will save to realm.")

    let dateTimeInterval = Date().timeIntervalSince1970

    let event = Event()
    event.createAt = dateTimeInterval
    event.modifiedAt = dateTimeInterval
    event.name = text
    event.add()

    taskInputView.clearText()
  }

  @objc func add() {
    Logger.debug("Show taskView.")

    if addTextField.isFirstResponder {
      taskInputView.resignFirstResponder()
      addTextField.resignFirstResponder()
      addTaskView.isHidden = false
      done()
    } else {
      addTextField.becomeFirstResponder()
      addTaskView.isHidden = true
    }
  }
}
