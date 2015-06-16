//
//  ViewController.m
//  ActionTableViewSample
//
//  Created by VANGELI ONTIVEROS on 29/08/14.
//
//

#import "SampleViewController.h"
#import "CustomTableViewCell.h"

@interface SampleViewController ()

@property (strong, nonatomic) NSMutableArray *itemsList;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *reorderButton;

- (IBAction)reorderButtonTapped:(id)sender;


@end

@implementation SampleViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.itemsList = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++) {
        [self.itemsList addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction's

- (IBAction)reorderButtonTapped:(UIBarButtonItem *)sender {
    
    
    if (self.tableView.isEditing) {
        [sender setTitle:@"Reorder"];
        [sender setStyle:UIBarButtonItemStylePlain];
        [self.tableView setEditing:NO animated:YES];
    }else{
        [sender setTitle:@"Done"];
        [sender setStyle:UIBarButtonItemStyleDone];
        [self.tableView setEditing:YES animated:YES];
    }

}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.itemsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    
    
    
    cell.customText = [NSString stringWithFormat:@"List Item: [%@]",self.itemsList[indexPath.row]];
    
    
    return cell;
}

/*Moving rows
 Must implement this method in order to allow the "Move control" to appear (Xcode 6 Beta 6)*/
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    [self.itemsList exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


#pragma mark UITableViewRowAction

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak SampleViewController *weakSelf = self;
    
    UITableViewRowAction *actionGreen =
    [UITableViewRowAction
     rowActionWithStyle:UITableViewRowActionStyleNormal
     title:@"Add Below"
     handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
         NSLog(@"Add!");
         
         [weakSelf.itemsList insertObject:@(arc4random_uniform(100) + 100) atIndex:indexPath.row + 1];
         [weakSelf.tableView setEditing:NO animated:YES];
         [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row + 1
                                                                         inSection:indexPath.section]]
                                   withRowAnimation:UITableViewRowAnimationAutomatic];
         
     }];
    
    actionGreen.backgroundColor = [UIColor colorWithRed:0.323 green:0.814 blue:0.303 alpha:1.000];
    
    UITableViewRowAction *actionRed =
    [UITableViewRowAction
     rowActionWithStyle:UITableViewRowActionStyleNormal
     title:@"Delete"
     handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
         NSLog(@"Delete!");
         
         [weakSelf.itemsList removeObjectAtIndex:indexPath.row];
         [weakSelf.tableView setEditing:NO animated:YES];
         [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath]
                                   withRowAnimation:UITableViewRowAnimationAutomatic];
         
     }];
    
    actionRed.backgroundColor = [UIColor colorWithRed:0.844 green:0.242 blue:0.292 alpha:1.000];
    
    
    return @[actionGreen,actionRed];
}


/*
 * Must implement this method to make 'UITableViewRowAction' work.
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark - UITableViewDelegate

//Displaying
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    cell.contentView.backgroundColor = [UIColor blueColor];
//    
//    cell.backgroundColor = [UIColor purpleColor];
    
}

//Editing Table Rows
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     return UITableViewCellEditingStyleNone when entering on "Reorder Mode".
     This will make the "Move control" appear but without the "minus circle" although the tableCell will indent
     (we still need to specify that we don't want this indentation)
        
     return UITableViewCellEditingStyleDelete in order to make the "UITableViewRowAction" work.
     I couldn't find any explanation in the docs (Xcode 6 beta 6), I've come to this conclusion through trial & error :P
     
     */
    
    return self.tableView.isEditing ? UITableViewCellEditingStyleNone: UITableViewCellEditingStyleDelete;
}


//Don't indent the cell 'cause only the move control is going to appear (see: editingStyleForRowAtIndexPath )
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

//selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected: %@", indexPath);
    
}


@end






































