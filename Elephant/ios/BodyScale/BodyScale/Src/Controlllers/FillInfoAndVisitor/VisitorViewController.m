//
//  WelcomeViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-25.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "VisitorViewController.h"
#import "LoginViewController.h"
#import "RegistFirstViewController.h"
#import "FillInfoViewController.h"
@interface VisitorViewController ()


@end

@implementation VisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBarHidden = YES;
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@215.5);
        make.height.equalTo(@165.5);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@80);
    }];
//    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@232);
//        make.height.equalTo(@44);
//    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginAction:(id)sender
{
    [self.navigationController pushViewController:[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] animated:YES];
}

- (IBAction)registAction:(id)sender
{
    
    [self.navigationController pushViewController:[[RegistFirstViewController alloc] initWithNibName:@"RegistFirstViewController" bundle:nil] animated:YES];
}

-(IBAction)visitorAcion:(id)sender
{
   [self.navigationController pushViewController:[[FillInfoViewController alloc] initWithNibName:@"FillInfoViewController" bundle:nil] animated:YES];
}
@end
