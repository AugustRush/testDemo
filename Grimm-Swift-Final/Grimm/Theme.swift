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

import Foundation
import UIKit

enum Font: Int {
  case FiraSans = 0, NotoSans, OpenSans, PTSans, SourceSansPro, System
}

enum ReadingMode: Int {
  case Daytime = 0, NightTime
}

enum TitleAlignment: Int {
  case Center = 0, Left
}

let ThemeDidChangeNotification = "ThemeDidChangeNotification"

protocol ThemeAdopting {
  func reloadTheme()
}

private let _singletonThemeInstance = Theme()

class Theme {
  
  class var sharedInstance: Theme {
  return _singletonThemeInstance
  }
  
  private let fonts = [
    ["FiraSans-Regular",
      "NotoSans",
      "OpenSans-Regular",
      "PTSans-Regular",
      "SourceSansPro-Regular"],
    ["FiraSans-SemiBold",
      "NotoSans-Bold",
      "OpenSans-Semibold",
      "PTSans-Bold",
      "SourceSansPro-Semibold"]
  ]
  private let textBackgroundColors = [UIColor.whiteColor(), UIColor.nightTimeTextBackgroundColor()]
  private let textColors = [UIColor.darkTextColor(), UIColor.nightTimeTextColor()]
  
  var font: Font = .FiraSans {
    didSet {
      notifyObservers()
    }
  }
  
  var readingMode: ReadingMode = .Daytime {
    didSet {
      notifyObservers()
    }
  }
  var titleAlignment: TitleAlignment = .Center {
    didSet {
      notifyObservers()
    }
  }
  
  var barTintColor: UIColor {
    let color = textBackgroundColors[readingMode.toRaw()]
      return color.colorForTranslucency()
  }
  
  var tintColor: UIColor? {
    if readingMode == .Daytime {
      return nil
    } else {
      return UIColor.nightTimeTintColor()
      }
  }
  
  var separatorColor: UIColor {
    if readingMode == .Daytime {
      return UIColor.defaultSeparatorColor()
    } else {
      return UIColor.nightTimeTintColor()
      }
  }
  
  var textBackgroundColor: UIColor {
    return textBackgroundColors[readingMode.toRaw()]
  }
  
  var textColor: UIColor {
    return textColors[readingMode.toRaw()]
  }
  
  func preferredFontForTextStyle(style: String) -> UIFont {
    let systemFont = UIFont.preferredFontForTextStyle(style)
    
    if font == .System {
      return systemFont
    }
    
    let size = systemFont.pointSize
    var preferredFont: UIFont
    
    if style == UIFontTextStyleHeadline {
      preferredFont = UIFont(name: fonts[1][font.toRaw()], size: size)
    } else {
      preferredFont = UIFont(name: fonts[0][font.toRaw()], size: size)
    }
    
    return preferredFont
  }
  
  private func notifyObservers() {
    NSNotificationCenter.defaultCenter().postNotificationName(ThemeDidChangeNotification, object: nil)
  }
}