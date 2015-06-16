//
//  UITableViewMoreCell.m
//  FFLtd
//
//  Created by 两元鱼 on 10/4/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//

#import "UITableViewMoreCell.h"

static const CGFloat kMoreButtonMargin = 26;
static const CGFloat kSmallMargin = 21;

@implementation UITableViewMoreCell

@synthesize  activityIndicatorView = _activityIndicatorView;

@synthesize  animating = _animating;

@synthesize  title = _title;


-(void)dealloc
{
}


+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    
    return  48;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier
{
    if (self = [super initWithStyle:style reuseIdentifier:identifier])
    {
        
        self.textLabel.font = BOLDFONT15;
        
        self.textLabel.textColor = [UIColor blackColor];
        
      // self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
        
        //self.backgroundView = backgroundView;
    
        _animating = NO;
        
        _activityIndicatorView = nil;
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
	self.textLabel.text = L(self.title);
    
    self.textLabel.frame = CGRectMake(kMoreButtonMargin, self.textLabel.frame.origin.y,
                                      self.contentView.frame.size.width - (kMoreButtonMargin + kSmallMargin),
                                      self.textLabel.frame.size.height);
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    
    self.activityIndicatorView.frame = CGRectMake(self.textLabel.frame.size.width/2-50, self.textLabel.frame.origin.x, self.activityIndicatorView.frame.size.width, self.activityIndicatorView.frame.size.height);
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewCell



///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (UIActivityIndicatorView*)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (void)setAnimating:(BOOL)animating
{
    if (_animating != animating)
    {
        _animating = animating;
        
        if (_animating)
        {
            [self.activityIndicatorView startAnimating];
        }
        else {
            [_activityIndicatorView stopAnimating];
        }
        [self setNeedsLayout];
    }
}


@end
