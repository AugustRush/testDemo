/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class StoryCell: UITableViewCell, ThemeAdopting {
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String!)  {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  var story: Story? {
    didSet {
      titleLabel.text = story!.title
      previewLabel.text = story!.content
      reloadTheme()
      setNeedsUpdateConstraints()
    }
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.opaque = true
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    return label
    }()
  
  private var previewLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 3
    label.opaque = true
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    return label
    }()
  
  func reloadTheme()  {
    let theme = Theme.sharedInstance
    
    backgroundColor = theme.textBackgroundColor
    contentView.backgroundColor = theme.textBackgroundColor
    
    titleLabel.backgroundColor = theme.textBackgroundColor
    titleLabel.font = theme.preferredFontForTextStyle(UIFontTextStyleHeadline)
    titleLabel.textColor = theme.textColor
    
    previewLabel.backgroundColor = theme.textBackgroundColor
    previewLabel.font = theme.preferredFontForTextStyle(UIFontTextStyleBody)
    previewLabel.textColor = theme.textColor
  }
  
  private func setup() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(previewLabel)
    
    var constraints = [NSLayoutConstraint]()
    
    constraints.append(NSLayoutConstraint(
      item: titleLabel,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: contentView,
      attribute: .Top,
      multiplier: 1,
      constant: 15))
    constraints.append(NSLayoutConstraint(
      item: previewLabel,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: titleLabel,
      attribute: .Bottom,
      multiplier: 1,
      constant: 8))
    constraints.append(NSLayoutConstraint(
      item: contentView,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: previewLabel,
      attribute: .Bottom,
      multiplier: 1,
      constant: 15))
    constraints.append(NSLayoutConstraint(
      item: titleLabel,
      attribute: .Height,
      relatedBy: .GreaterThanOrEqual,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 20))
    constraints.append(NSLayoutConstraint(
      item: previewLabel,
      attribute: .Height,
      relatedBy: .GreaterThanOrEqual,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 20))
    constraints.append(NSLayoutConstraint(
      item: contentView,
      attribute: .Height,
      relatedBy: .GreaterThanOrEqual,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 64))
    
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-|", options: .convertFromNilLiteral(), metrics: nil, views: ["titleLabel": titleLabel]) as [NSLayoutConstraint]
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[previewLabel]-15-|", options: .convertFromNilLiteral(), metrics: nil, views: ["previewLabel": previewLabel]) as [NSLayoutConstraint]
    
    contentView.addConstraints(constraints)
    reloadTheme()
  }
}
