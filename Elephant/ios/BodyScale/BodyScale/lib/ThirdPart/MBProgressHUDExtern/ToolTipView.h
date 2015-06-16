//
//  ToolTipView.h
//  FFLtd5
//
//  Created by Hubert Ryan on 11-6-21.
//  Copyright 2011 FFLtd. All rights reserved.
//


@protocol ToolTipViewDelegate;

@interface ToolTipView : UIView {

    @private
	UILabel *label;
	
	NSString *_labelText;
	
	float yOffset;
	
    float xOffset;
	
	UIFont *labelFont;
	
	CGRect boxRect;
	
	UIView *bkView;
	
	CGFloat   autoHideInterval;
        
    NSTimer *dlgTimer_;
}



@property (nonatomic, strong) NSString *labelText;

@property (nonatomic, strong) UIFont *labelFont;

@property (nonatomic, assign) float yOffset;

@property (nonatomic, assign) float xOffset;

@property (nonatomic, assign) CGFloat autoHideInterval;

@property (nonatomic, assign) id<ToolTipViewDelegate> delegate;

@property (nonatomic, strong) NSTimer *dlgTimer;

- (id)initWithView:(UIView *)view ;

- (void)fillRoundedRect:(CGRect)rect inContext:(CGContextRef)context ;

@end


@protocol ToolTipViewDelegate <NSObject>

- (void)tipViewWasHidden:(ToolTipView *)tipView;

@end
