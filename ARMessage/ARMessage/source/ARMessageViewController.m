//
//  ARMessageViewController.m
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARMessageViewController.h"
#import "ARTextMessageInComingCell.h"
#import "UIView+autolayout.h"
#import "ARMessageInputBar.h"
#import "ARMessageCaculator.h"

@interface ARMessageViewController ()<UITableViewDelegate,UITableViewDataSource,ARMessageInputBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ARMessageInputBar *inputBar;
@property (nonatomic, strong) NSMutableArray *messages;


@property (nonatomic, strong) NSLayoutConstraint *inputBarBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *inputBarHeightConstraint;

@end

@implementation ARMessageViewController

#pragma mark - life cycle methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initialData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self baseConfigs];
    [self baseLayout];
    [self addNotifications];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count -1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
}

#pragma mark - private methods

-(void)initialData
{
    self.messages = [NSMutableArray array];
    
}

-(void)baseConfigs
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ARTextMessageInComingCell" bundle:nil] forCellReuseIdentifier:@"ARTextMessageInComingCell"];
    
    
    self.inputBar = [[ARMessageInputBar alloc] init];
    self.inputBar.delegate = self;
    [self.view addSubview:self.inputBar];
}

-(void)baseLayout
{
    [self.tableView pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeLeft inset:0];
    [self.tableView pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeRight inset:0];
    [self.tableView pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeTop inset:0];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.inputBar
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    
    [self.inputBar pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeLeft inset:0];
    [self.inputBar pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeRight inset:0];
    self.inputBarBottomConstraint = [self.inputBar pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeBottom inset:0];
}

-(void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidDraged:) name:ARMessageInputKeyBoardFrameChangedNotification object:nil];
}

-(UIView *)inputAccessoryView
{
    ARMessageInputAccessoryView *accessoryView = [ARMessageInputAccessoryView new];
    return accessoryView;
}

-(void)scrollToBottomAniamted:(BOOL)animated
{
    if (self.messages.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
        [UIView animateWithDuration:animated?0.2:0.0
                         animations:^{
                             [self.tableView scrollToRowAtIndexPath:indexPath
                                                   atScrollPosition:UITableViewScrollPositionTop
                                                           animated:NO];
                         }];
    }
}

#pragma mark - message handle methods

-(void)addMessage:(id<ARMessageProtocol>)message
{
    [self.messages addObject:message];
    [self.tableView reloadData];
    [self scrollToBottomAniamted:YES];
}

#pragma mark - ovveride methods

-(void)sendMessageWithText:(NSString *)text
{}

-(void)rightButtonTapped:(UIButton *)sender
{}

#pragma mark - ARMessageInputBarDelegate methods

-(void)ar_MessageInputBar:(ARMessageInputBar *)inputBar didSendText:(NSString *)text
{
    [self sendMessageWithText:text];
}

-(void)ar_MessageInputBar:(ARMessageInputBar *)inputBar didTriggerRightButton:(UIButton *)button
{
    [self rightButtonTapped:button];
}

#pragma mark - notification methods

-(void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGFloat keyboardHeight = keyboardBounds.size.height;

    self.inputBarBottomConstraint.constant = -keyboardHeight;
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:duration.doubleValue
                          delay:0
                        options:curve.intValue << 16
                     animations:^{
                         [self.view layoutIfNeeded];
                         [self scrollToBottomAniamted:NO];
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    self.inputBarBottomConstraint.constant = 0;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:duration.doubleValue
                          delay:0
                        options:curve.intValue << 16
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)keyboardDidDraged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardShowHeight = CGRectGetHeight(self.view.bounds) - [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    self.inputBarBottomConstraint.constant = -keyboardShowHeight;
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<ARMessageProtocol> message = self.messages[indexPath.row];
    return [ARMessageCaculator heightWithMessage:message showTime:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<ARMessageProtocol> message = self.messages[indexPath.row];
    ARTextMessageInComingCell *textIncomingCell = [tableView dequeueReusableCellWithIdentifier:@"ARTextMessageInComingCell" forIndexPath:indexPath];
    [textIncomingCell fillWithMessage:message];
    return textIncomingCell;
}

#pragma mark - UITableViewDelegate methods

#pragma mark - manage memroy methods

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
