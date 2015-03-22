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

class Story {
  var title: String
  var content: String
  
  init(title: String, content: String) {
    self.title = title
    self.content = content
  }
  
  func description() -> String {
    return title
  }
  
  class func loadStories(completion: ((Array<Story>?, NSErrorPointer) -> Void)!) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      var error: NSErrorPointer = nil
      let path = NSBundle.mainBundle().bundlePath
      let manager = NSFileManager.defaultManager()
      
      var stories = [Story]()
      
      if let contents = manager.contentsOfDirectoryAtPath(path, error: error) {
        error = nil
        
        for file in contents {
          if file.hasSuffix(".grm") {
            let filePath = path.stringByAppendingPathComponent(file as String)
            let title = file.stringByDeletingPathExtension
            let content = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: error)
            
            let story = Story(title: title, content: content)
            
            if error != nil {
              break
            }
            
            stories.append(story)
            
            error = nil
          }
        }
      }
      
      stories.sort({ a, b in
        a.title < b.title
      })
      
      dispatch_async(dispatch_get_main_queue(), {
        if error != nil {
          completion(nil, error)
        } else {
          completion(stories, nil)
        }
      })
    });
  }
}