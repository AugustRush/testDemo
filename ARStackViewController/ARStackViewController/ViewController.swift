//
//  ViewController.swift
//  ARStackViewController
//
//  Created by August on 14-9-23.
//  Copyright (c) 2014年 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sstackViewController : ARStackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.purpleColor()
        let stackViewCotroller = ARStackViewController(rootViewController: viewController)
        stackViewCotroller.view.backgroundColor = UIColor.blueColor()
        self.addChildViewController(stackViewCotroller)
        self.view.addSubview(stackViewCotroller.view)
        self.sstackViewController = stackViewCotroller
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        let testViewCtr = testViewController()
//        var r,g,b : CGFloat
//        r  = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        g  = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        b  = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        
//        testViewCtr.view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
//        self.sstackViewController!.pushViewController(testViewCtr,animated:true)
//    }
    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//                let testViewCtr = UIViewController()
//        testViewCtr.view.backgroundColor = UIColor.brownColor()
//        println(self.stackViewController)
//        self.stackViewController?.pushViewController(testViewCtr, animated: false)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

