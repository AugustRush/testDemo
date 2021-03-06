//
//  TableViewController.m
//  swipeCellDemo
//
//  Created by August on 14-8-20.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "TableViewController.h"
#import "ARSwipeTableViewCell.h"

@interface TableViewController ()<ARSwipeTableViewCellDelegate,ARSwipeTableViewCellDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 20; i++) {
        [self.dataArr addObject:@"test"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentifier = @"swipeCell";
    
    ARSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[ARSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }

    cell.delegate = self;
    cell.dataSource = self;
    
    cell.textLabel.text = [NSString stringWithFormat:@"[%ld    %ld]",(long)indexPath.section,(long)indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    [self.dataArr removeObjectAtIndex:indexPath.row];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma cell delegate

-(void)swipeCell:(ARSwipeTableViewCell *)cell didTriggerLeftItemWithIndex:(NSInteger)index
{

}

-(void)swipeCell:(ARSwipeTableViewCell *)cell didTriggerRightItemWithIndex:(NSInteger)index
{

}

#pragma cell datasource

-(NSArray *)leftItemsForSwipeCell:(ARSwipeTableViewCell *)cell
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"delete" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    return @[button];
}

-(NSArray *)rightItemsForSwipeCell:(ARSwipeTableViewCell *)swipeCell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeCell];
    if (indexPath.row % 2 == 0) {
        NSLog(@"1111111");
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"add" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        return @[button];
    }else{
        NSLog(@"2222222");
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"bbbbbbb" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        return @[button];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
