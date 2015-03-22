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

extension UIColor {
  func colorForTranslucency() -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
  
  class func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
  }
  
  class func defaultSeparatorColor() -> UIColor {
    return rgba(200, green: 199, blue: 204, alpha: 1)
  }
  
  class func nightTimeTextBackgroundColor() -> UIColor {
    return rgba(245, green: 238, blue: 220, alpha: 1)
  }
  
  class func nightTimeTextColor() -> UIColor {
    return rgba(50, green: 20, blue: 0, alpha: 1)
  }
  
  class func nightTimeTintColor() -> UIColor {
    return rgba(182, green: 126, blue: 44, alpha: 1)
  }
}