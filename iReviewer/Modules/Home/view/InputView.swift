//
//  InputView.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class InputView: UIView {
  private var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = R.image.iconCircle()
    return imageView
  }()

  private var inputTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = R.string.root.todoAdd()
    textField.font = .body2
    textField.attributedPlaceholder = NSAttributedString(string: R.string.root.todoAdd(), attributes: [.foregroundColor: UIColor.gray])
    textField.contentVerticalAlignment = .center
    return textField
  }()

  override var canBecomeFirstResponder: Bool {
    return true
  }

  override var canResignFirstResponder: Bool {
    return true
  }

  public var inputText: String?

  public func clearText() {
    inputText = nil
    inputTextField.text = ""
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    backgroundColor = .white

    inputTextField.addTarget(self, action: #selector(inputTextChanged), for: .editingChanged)

    // Set corner only top.
    corner(byRoundingCorners: [.topLeft, .topRight], radii: 8)

    addSubview(iconImageView)
    addSubview(inputTextField)

    // AutoLayout
    iconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
    iconImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
    iconImageView.autoSetDimensions(to: CGSize(width: 24, height: 24))

    inputTextField.autoPinEdge(.left, to: .right, of: iconImageView, withOffset: 16)
    inputTextField.autoAlignAxis(toSuperviewAxis: .horizontal)
    inputTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
  }

  @objc private func inputTextChanged() {
    inputText = inputTextField.text
  }
}
