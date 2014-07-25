//
//  ARViewController.m
//  realmDemo
//
//  Created by August on 14-7-25.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ARViewController.h"
#import <Realm/Realm.h>

@interface ARViewController ()

@property (nonatomic, retain) RLMRealm *defaultRealm;

- (IBAction)simpleSegmentcClicked:(id)sender;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self deleteRealmFile];
    self.defaultRealm = [RLMRealm defaultRealm];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)simpleSegmentcClicked:(UISegmentedControl *)sender {
    NSInteger value = sender.selectedSegmentIndex;
    switch (value) {
        case 0:
        {
            for (int i = 0; i <1000 ; i++) {
                Dog *dog = [[Dog alloc] init];
                dog.age = i*2;
                dog.name = [NSString stringWithFormat:@"%d",arc4random()];
                [self.defaultRealm beginWriteTransaction];
                [self.defaultRealm addObject:dog];
                [self.defaultRealm commitWriteTransaction];
            }
            
        }
            break;

        case 1:
        {
            RLMArray *result = [Dog allObjectsInRealm:self.defaultRealm];
            NSLog(@"result is %@, count is %d",result,result.count);
            NSLog(@"result query condition is %@",[result objectsWhere:@"name contains '19'"]);
             NSLog(@"result query condition is %@",[result objectsWhere:@"age >= 10"]);
            
        }
            break;

        case 2:
        {
            Person *newPerson = [[Person alloc] init];
            newPerson.name = @"liupingwei";
            RLMArray *dogs = [Dog objectsInRealm:self.defaultRealm where:@"age >= 10"];
            [newPerson.dogs addObjectsFromArray:dogs];
            [self.defaultRealm beginWriteTransaction];
            [self.defaultRealm addObject:newPerson];
            [self.defaultRealm commitWriteTransaction];
        }
            break;

        case 3:
        {
            NSLog(@"all perosn is %@",[Person allObjects]);
        }
            break;

            
        default:
            break;
    }
    
}

- (void)deleteRealmFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"default.realm"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

@end
