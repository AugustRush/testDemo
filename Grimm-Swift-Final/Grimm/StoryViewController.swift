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

class StoryViewController: UIViewController, ThemeAdopting {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var storyView: StoryView!
  @IBOutlet weak var optionsContainerView: UIView!
  @IBOutlet weak var optionsContainerViewBottomConstraint: NSLayoutConstraint!
  var showingOptions = false
  var blurView = UIImageView()
  
  var story: Story?
  
  required init(coder aDecoder: NSCoder)  {
    super.init(coder: aDecoder)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("themeDidChange:"),
      name: ThemeDidChangeNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let image = UIImage(named: "Bull")
    let imageView = UIImageView(image: image)
    navigationItem.titleView = imageView
    reloadTheme()
    if story != nil {
      storyView.story = story
    }
    
//    optionsContainerView.subviews[0].insertSubview(blurView,
//      atIndex:0)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    setOptionsHidden(true, animated: false)
  }
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    // 1
    coordinator.animateAlongsideTransition(nil, completion: { context in
    // 2
    self.updateBlur()
    })
  }
  
  @IBAction func optionsButtonTapped(AnyObject) {
    setOptionsHidden(showingOptions, animated: true)
  }
  
  func updateBlur() {
    // 1
    optionsContainerView.hidden = true
    
    // 2
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size,
    true, 1)
    // 3
    self.view.drawViewHierarchyInRect(self.view.bounds,
    afterScreenUpdates: true)
    // 4
    let screenshot = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let blur = screenshot.applyLightEffect()
    
    blurView.frame = optionsContainerView.bounds
    blurView.image = blur
    blurView.contentMode = .Bottom
    
    optionsContainerView.hidden = false
  }
  
  private func setOptionsHidden(hidden: Bool, animated: Bool) {
    if !hidden {
//      updateBlur()
    }
    
    showingOptions = !hidden;
    let height = CGRectGetHeight(optionsContainerView.bounds)
    var constant = optionsContainerViewBottomConstraint.constant
    constant = hidden ? (constant - height) : (constant + height)
    view.layoutIfNeeded()
    
    if animated {
      UIView.animateWithDuration(0.2,
        delay: 0,
        usingSpringWithDamping: 0.95,
        initialSpringVelocity: 1,
        options: .AllowUserInteraction | .BeginFromCurrentState,
        animations: {
          self.optionsContainerViewBottomConstraint.constant = constant
          self.view.layoutIfNeeded()
        }, completion: nil)
    } else {
      optionsContainerViewBottomConstraint.constant = constant
    }
  }
  
  func themeDidChange(notification: NSNotification!) {
    reloadTheme()
    storyView.reloadTheme()
  }
  
  func reloadTheme() {
    let theme = Theme.sharedInstance
    scrollView.backgroundColor = theme.textBackgroundColor
    for viewController in childViewControllers {
      if let controller = viewController as? UIViewController {
        controller.view.tintColor = theme.tintColor
      }
    }
  }
  
}