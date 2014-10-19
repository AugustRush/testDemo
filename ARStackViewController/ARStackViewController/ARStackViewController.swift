//
//  ARStackViewController.swift
//  ARStackViewController
//
//  Created by August on 14-9-27.
//  Copyright (c) 2014年 August. All rights reserved.
//

import UIKit

//MARK: delegate methods
protocol ARStackViewControllerDelegate{
    
}

class ARStackViewController : UIViewController{

    //MARK: properties
    var rootViewController:UIViewController?
    var delegate : ARStackViewControllerDelegate?
    private
    let panGestureReocgnizer = UIPanGestureRecognizer()
    let animationTimeInteravl = 0.3
    
    //MARK: life cycle methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(rootViewController:UIViewController) {
        self.init(nibName :nil,bundle:nil)
        self.rootViewController = rootViewController
        self.push(rootViewController, animated: false)
        panGestureReocgnizer.addTarget(self, action: "panGestureHandle:")
        self.view.addGestureRecognizer(panGestureReocgnizer)
    }
    
    //MARK: public methods
    
    func push(viewController:UIViewController, animated:Bool)->Void{
        self.addChildViewController(viewController)
        viewController.willMoveToParentViewController(self)
        self.view.addSubview(viewController.view)
        
        if animated{
            let width = CGRectGetWidth(self.view.bounds)
            let height = CGRectGetHeight(self.view.bounds)
            viewController.view.frame = CGRectMake(width ,0, width, height)
            UIView.animateWithDuration(animationTimeInteravl,animations: { () -> Void in
                viewController.view.frame = CGRectMake(0, 0, width, height)
                },
                completion: { (finishde:Bool) -> Void in
                    viewController.didMoveToParentViewController(self)
            });
        }else{
            viewController.didMoveToParentViewController(self)
        }
    }
    
    func pop(viewController:UIViewController)->Void{
        
        let width = CGRectGetWidth(self.view.bounds)
        let height = CGRectGetHeight(self.view.bounds)
        
        viewController.willMoveToParentViewController(nil)
        UIView.animateWithDuration(animationTimeInteravl, animations: { () -> Void in
            viewController.view.frame = CGRectMake(width, 0, width, height)
        }) { (finished:Bool) -> Void in
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
            viewController.didMoveToParentViewController(nil)
        };
    }
    //MARK: internal methods
    internal
    func panGestureHandle(panGesture:UIPanGestureRecognizer)->Void{
        
        if self.childViewControllers.count == 0 {
            return
        }
        
        let offset : CGPoint = panGesture.translationInView(self.view)
        let width = CGRectGetWidth(self.view.bounds)
        let height = CGRectGetHeight(self.view.bounds)
        
        switch (panGesture.state)
        {
        case .Began:
            fallthrough
        case .Possible:
            fallthrough
        case .Changed:
            if let view = topView(){
                    view.center = CGPointMake(width/2+offset.x, view.center.y)
            }
        case .Ended:
            if offset.x > width/2{
                pop(topViewController()!);
            }else{
                UIView.animateWithDuration(0.3, animations:
                    { () -> Void in
                        self.topView()!.center = self.view.center
                    },
                    completion:
                    { (finisged:Bool) -> Void in
                    
                    })
            }
        default:
            topView()?.center = self.view.center
        }
        
    }
    
    
    func topViewController()->UIViewController?{
        return self.childViewControllers.last as? UIViewController
    }
    
    func topView()->UIView?{
        return topViewController()?.view
    }
    
    //MARK: manage memory methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIViewController{
    var stackViewController:ARStackViewController? {
        get{
            var viewController = self.parentViewController
            if viewController != nil{
                if viewController!.isKindOfClass(ARStackViewController.self){
                    return viewController as? ARStackViewController
                }
            }
            return nil
        }
    }
}
