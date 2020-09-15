//
//  MenuCell.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
  private var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .customYuantiRegularFont(ofSize: 15)
    label.textColor = .black
    return label
  }()

  private var subTitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .body3
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    setupUI()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func setMenuItem(_ item: MenuItem) {
    iconImageView.image = item.iconImage
    titleLabel.text = item.title
    subTitleLabel.text = item.subTitle
  }

  private func setupUI() {
    contentView.addSubview(iconImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subTitleLabel)

    // AutoLayout
    iconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
    iconImageView.autoSetDimensions(to: CGSize(width: 24, height: 24))
    iconImageView.autoAlignAxis(toSuperviewAxis: .horizontal)

    titleLabel.autoPinEdge(.left, to: .right, of: iconImageView, withOffset: 16)
    titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: iconImageView)

    subTitleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
    subTitleLabel.autoAlignAxis(.horizontal, toSameAxisOf: iconImageView)
  }
}
