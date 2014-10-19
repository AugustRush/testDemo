//
//  testViewController.swift
//  ARStackViewController
//
//  Created by August on 14-9-27.
//  Copyright (c) 2014年 August. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("teststststst  \(self.stackViewController)")
        let controller  = UIViewController()
        controller.view.backgroundColor = UIColor.redColor()
        self.stackViewController?.push(controller, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
