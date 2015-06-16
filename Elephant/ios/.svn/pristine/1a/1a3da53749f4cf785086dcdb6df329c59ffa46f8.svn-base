//
//  PickerButton.m
//  FFLtd
//
//  Created by  on 12-10-6.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "PickerButton.h"

@interface PickerButton()

@property (nonatomic,strong) UIView                     *inputView;
@property (nonatomic,strong) UIView                     *inputAccessoryView;
@property (nonatomic,strong) UIPickerView               *pickerView;
@property (nonatomic,strong) UIToolbar                  *aboveViewToolBar;
@end

/*********************************************************************/

@implementation PickerButton

@synthesize delegate = _delegate;
@synthesize itemList = _itemList;
@synthesize selectIndex = _selectIndex;
@synthesize selectItem = _selectItem;
@synthesize isShowSelectItemOnButton = _isShowSelectItemOnButton;

@synthesize nomalBgColor = _nomalBgColor;
@synthesize activeBgColor = _activeBgColor;

@synthesize inputView = _inputView;
@synthesize inputAccessoryView = _inputAccessoryView;
@synthesize pickerView = _pickerView;
@synthesize aboveViewToolBar = _aboveViewToolBar;


- (void)dealloc
{
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    return [[self alloc] initWithItemList:nil];
}

- (id)init {
    self = [self initWithItemList:nil];
    if (self) {

    }
    return self;
}

- (id)initWithItemList:(NSArray *)list
{
    self = [super init];
    if (self) {
        self.itemList = list;
        [self addTarget:self 
                 action:@selector(buttonTapped:) 
       forControlEvents:UIControlEventTouchUpInside];
        
        self.inputView = self.pickerView;
        self.inputAccessoryView = self.aboveViewToolBar;
        _selectIndex = 0;
    }
    return self;
}

#pragma mark -
#pragma mark getters

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

- (UIToolbar *)aboveViewToolBar
{
    if (!_aboveViewToolBar)
    {
        _aboveViewToolBar = [[UIToolbar alloc] init];
        _aboveViewToolBar.barStyle = UIBarStyleBlack;
        _aboveViewToolBar.translucent = YES;
        
        [_aboveViewToolBar sizeToFit];
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil];
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
                                          initWithTitle:L(@"Cancel")
                                          style:UIBarButtonItemStyleBordered 
                                          target:self
                                          action:@selector(cancelClicked:)];
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]
                                        initWithTitle:L(@"Ok")
                                        style:UIBarButtonItemStyleBordered 
                                        target:self
                                        action:@selector(doneClicked:)];
        
        [_aboveViewToolBar setItems:[NSArray arrayWithObjects:
                                     cancelButton,
                                     flexItem,
                                     doneButton, nil]];
    }
    
    return _aboveViewToolBar;
}

#pragma mark -
#pragma mark setters

- (void)setNomalBgColor:(UIColor *)nomalBgColor
{
    if (nomalBgColor != _nomalBgColor) {
        _nomalBgColor = nomalBgColor;
        self.backgroundColor = _nomalBgColor;
    }
}

- (void)setSelectItem:(NSString *)selectItem
{
    if (_selectItem != selectItem) {
        _selectItem = [selectItem copy];
        
        if (_isShowSelectItemOnButton) {
            [self setTitle:selectItem forState:UIControlStateNormal];
        }
    }
}

- (void)setIsShowSelectItemOnButton:(BOOL)isShowSelectItemOnButton
{
    _isShowSelectItemOnButton = isShowSelectItemOnButton;
    if (isShowSelectItemOnButton) {
        [self setTitle:_selectItem forState:UIControlStateNormal];
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex < 0 || selectIndex >= [_itemList count]) {
        return;
    }
    _selectIndex = selectIndex;
    NSString *value = [_itemList objectAtIndex:selectIndex];
    [self setSelectItem:value];
}

- (void)setItemList:(NSArray *)itemList
{
    if (_itemList != itemList) {
        _itemList = itemList;
        [self.pickerView reloadAllComponents];
        [self setSelectIndex:0];
    }
}

#pragma mark -
#pragma mark picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _itemList?[_itemList count]:0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSString *titleStr = [_itemList objectAtIndex:row];
    NSAssert([titleStr isKindOfClass:[NSString class]], @"titleStr is not a NSString");
    return titleStr;
}


#pragma mark -
#pragma mark actions

- (void)cancelClicked:(id)sender
{
    
    [self resignFirstResponder];
}

- (void)doneClicked:(id)sender
{
    NSInteger select = [self.pickerView selectedRowInComponent:0];
    
    BOOL canSelect = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(pickerButton:canSelectIndex:)]) {
        canSelect = [_delegate pickerButton:self canSelectIndex:select];        
    }
    
    if (canSelect) {
        [self setSelectIndex:select];
        
        [self resignFirstResponder];
        
        if (_delegate && [_delegate respondsToSelector:@selector(pickerButton:didSelectIndex:andItem:)])
        {
            [_delegate pickerButton:self didSelectIndex:_selectIndex andItem:_selectItem];
        }
    }else{
        
    }
}

- (void)buttonTapped:(id)sender
{
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    if (_activeBgColor) {
        self.backgroundColor = _activeBgColor;
    }
    return YES;
}

- (BOOL)canResignFirstResponder
{
    if (_nomalBgColor) {
        self.backgroundColor = _nomalBgColor;
    }
    return YES;
}
@end
