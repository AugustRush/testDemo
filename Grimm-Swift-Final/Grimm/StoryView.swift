
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

class StoryView: UIView, ThemeAdopting {
  
  override func awakeFromNib() {
    setup()
  }
  
  var story: Story? {
    didSet {
      titleLabel.text = story!.title
      contentLabel.text = story!.content
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
  
  private var contentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.opaque = true
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    return label
    }()
  
  private var separatorView: UIView = {
    let view = UIView()
    view.opaque = true
    view.setTranslatesAutoresizingMaskIntoConstraints(false)
    return view
    }()
  
  func reloadTheme()  {
    let theme = Theme.sharedInstance
    backgroundColor = theme.textBackgroundColor
    
    titleLabel.backgroundColor = theme.textBackgroundColor
    titleLabel.font = theme.preferredFontForTextStyle(UIFontTextStyleHeadline)
    titleLabel.textColor = theme.textColor
    titleLabel.textAlignment = theme.titleAlignment == TitleAlignment.Center ? NSTextAlignment.Center : NSTextAlignment.Left
    
    contentLabel.backgroundColor = theme.textBackgroundColor
    contentLabel.font = theme.preferredFontForTextStyle(UIFontTextStyleBody)
    contentLabel.textColor = theme.textColor
    
    separatorView.backgroundColor = theme.separatorColor
  }
  
  private func setup() {
    addSubview(titleLabel)
    addSubview(separatorView)
    addSubview(contentLabel)
    
    var constraints = [NSLayoutConstraint]()
    
    constraints.append(NSLayoutConstraint(
      item: titleLabel,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: self,
      attribute: .Top,
      multiplier: 1,
      constant: 20))
    constraints.append(NSLayoutConstraint(
      item: titleLabel,
      attribute: .Height,
      relatedBy: .GreaterThanOrEqual,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 20))
    constraints.append(NSLayoutConstraint(
      item: separatorView,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: titleLabel,
      attribute: .Bottom,
      multiplier: 1,
      constant: 20))
    constraints.append(NSLayoutConstraint(
      item: separatorView,
      attribute: .Height,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 0.5))
    constraints.append(NSLayoutConstraint(
      item: contentLabel,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: separatorView,
      attribute: .Bottom,
      multiplier: 1,
      constant: 20))
    constraints.append(NSLayoutConstraint(
      item: self,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: contentLabel,
      attribute: .Bottom,
      multiplier: 1,
      constant: 15))
    
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-|", options: .convertFromNilLiteral(), metrics: nil, views: ["titleLabel": titleLabel]) as [NSLayoutConstraint]
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[separatorView]-15-|", options: .convertFromNilLiteral(), metrics: nil, views: ["separatorView": separatorView]) as [NSLayoutConstraint]
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[contentLabel]-15-|", options: .convertFromNilLiteral(), metrics: nil, views: ["contentLabel": contentLabel]) as [NSLayoutConstraint]
    
    addConstraints(constraints)
    reloadTheme()
  }
  
}
