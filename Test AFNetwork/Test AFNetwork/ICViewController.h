//
//  ICViewController.h
//  Test AFNetwork
//
//  Created by 刘平伟 on 14-5-1.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWHTTPClient.h"
#import <ImageIO/ImageIO.h>

@interface ICViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
