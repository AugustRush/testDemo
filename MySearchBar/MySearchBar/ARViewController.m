//
//  ARViewController.m
//  MySearchBar
//
//  Created by August on 14-7-28.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ARViewController.h"
#import "ARSearchBar.h"

@interface ARViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet ARSearchBar *mySearchBAr;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mySearchBAr.leftImage = [UIImage imageNamed:@"avatar_star_blue.png"];
    self.mySearchBAr.textColor = [UIColor redColor];//[UIColor colorWithRed:0/255.0 green:179/255.0 blue:231/255.0 alpha:1];
    self.mySearchBAr.searchTextFieldBackgoudColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:231/255.0 alpha:1];
    
    self.mySearchBAr.clearButtonImage = [UIImage imageNamed:@"avatar_stroke_160.png"];;
    self.mySearchBAr.font = [UIFont boldSystemFontOfSize:28];
    [self.mySearchBAr setPlaceholder:@"kkasdjlkaslk" withColor:[UIColor purpleColor]];
//    self.mySearchBAr.delegate = self;
//    self.mySearchBAr.leftImage = [UIImage imageNamed:@"avatar_star_blue.png"];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"aaaa");
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"ddddd");
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"bbbb");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
