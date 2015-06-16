//
//  ARTwoSideView.h
//  Mindssage
//
//  Created by August on 14-9-8.
//
//

#import <UIKit/UIKit.h>

@interface ARTwoSideView : UIView
{
    BOOL _isPrimary;
}

@property (nonatomic, strong) UIView *primaryView;
@property (nonatomic, strong) UIView *secondaryView;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSTimeInterval pauseDuration;

-(void)startRotaion;

@end
