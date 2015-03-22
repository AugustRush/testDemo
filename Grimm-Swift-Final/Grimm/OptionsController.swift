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

class OptionsController: UIViewController, UIScrollViewDelegate {
  
  var currentPage = 0
  @IBOutlet weak var readingModeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var titleAlignmentSegmentedControl: UISegmentedControl!
  @IBOutlet weak var pageControl: UIPageControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let optionsView = UINib(nibName: "OptionsView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as UIView
    scrollView.scrollsToTop = false
    view.addSubview(optionsView)
    
    // 1
    let blurEffect = UIBlurEffect(style: .Dark)
    // 2
    let blurView = UIVisualEffectView(effect: blurEffect)
    // 3
    blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
    view.insertSubview(blurView, atIndex: 0)
    
    // 1
    let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
    // 2
    let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
    vibrancyView.setTranslatesAutoresizingMaskIntoConstraints(false)
    // 3
    vibrancyView.contentView.addSubview(optionsView)
    // 4
    blurView.contentView.addSubview(vibrancyView)
    
    var constraints = [NSLayoutConstraint]()
    
    constraints.append(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal,
      toItem: optionsView, attribute: .CenterX, multiplier: 1, constant: 0))
    
    constraints.append(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal,
      toItem: optionsView, attribute: .CenterY, multiplier: 1, constant: 0))
    
    constraints.append(NSLayoutConstraint(item: blurView,
      attribute: .Height, relatedBy: .Equal, toItem: view,
      attribute: .Height, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: blurView,
      attribute: .Width, relatedBy: .Equal, toItem: view,
      attribute: .Width, multiplier: 1, constant: 0))
    
    constraints.append(NSLayoutConstraint(item: vibrancyView,
      attribute: .Height, relatedBy: .Equal,
      toItem: view, attribute: .Height,
      multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: vibrancyView,
      attribute: .Width, relatedBy: .Equal,
      toItem: view, attribute: .Width,
      multiplier: 1, constant: 0))
    
    view.addConstraints(constraints)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    scrollView.contentSize = CGSizeMake(1272, 44)
    
    let theme = Theme.sharedInstance
    readingModeSegmentedControl.selectedSegmentIndex = theme.readingMode.toRaw()
    titleAlignmentSegmentedControl.selectedSegmentIndex = theme.titleAlignment.toRaw()
    currentPage = theme.font.toRaw()
    pageControl.currentPage = currentPage
    synchronizeViews(false)
  }
  
  @IBAction func pageControlPageDidChange(AnyObject) {
    synchronizeViews(false)
  }
  
  @IBAction func readingModeDidChange(segmentedControl: UISegmentedControl!) {
    Theme.sharedInstance.readingMode = ReadingMode.fromRaw(segmentedControl.selectedSegmentIndex)!
  }
  
  @IBAction func titleAlignmentDidChange(segmentedControl: UISegmentedControl!) {
    Theme.sharedInstance.titleAlignment = TitleAlignment.fromRaw(segmentedControl.selectedSegmentIndex)!
  }
  
  private func synchronizeViews(scrolled: Bool) {
    let pageWidth = CGRectGetWidth(scrollView.bounds)
    var page: Int = 0
    var offset: CGFloat = 0
    
    if scrolled {
      offset = self.scrollView.contentOffset.x
      page = Int(offset / pageWidth)
      pageControl.currentPage = page
    } else {
      page = pageControl.currentPage
      offset = CGFloat(page) * pageWidth
      scrollView.setContentOffset(CGPointMake(offset, 0), animated: true)
    }
    
    if page != currentPage {
      currentPage = page
      Theme.sharedInstance.font = Font.fromRaw(currentPage)!
    }
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView!) {
    if scrollView.dragging || scrollView.decelerating {
      synchronizeViews(true)
    }
  }
  
}