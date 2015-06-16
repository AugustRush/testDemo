//
//  NewShareViewViewController.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-5-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "NewShareViewViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ShareEngine.h"
#import "UserInfoEntity.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ShareImage.h"
#import "CalculateTool.h"

@interface NewShareViewViewController () <ShareEngineDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *shareScrollView;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *friendBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *picScrollView;

@property (strong, nonatomic) UIImageView *backPicImgView;
@property (nonatomic, strong) UIImageView *headImgView;
@end

@implementation NewShareViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"分享";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    [self.weChatBtn addTarget:self action:@selector(weChatBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.friendBtn addTarget:self action:@selector(friendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sinaBtn addTarget:self action:@selector(sinaBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [ShareEngine sharedInstance].delegate = self;
    //    self.picScrollView.contentSize = CGSizeMake(320, 490);
    [[ShareEngine sharedInstance] registerApp];

    [self shareBackImage];
    [self addHeadImage];
    [self addUserName];
    [self addTime];
    [self MyRyFit];
    [self RyFitValue];
    [self addPeopleImageView];
    [self suggest];
    [self kaLuLi];
    [self addWantReachPerfectYouNeed];

}

- (void)shareBackImage
{
    UIImage *backImg = [UIImage imageNamed:@"beijingShare.png"];
    self.backPicImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backImg.size.width/2, backImg.size.height/2)];
    self.backPicImgView.image = backImg;
    [self.shareScrollView addSubview:self.backPicImgView];
    self.picScrollView.contentSize = CGSizeMake(320, backImg.size.height/2);

    UIView *bottomShareView = [self.view viewWithTag:111];
    [self.view bringSubviewToFront:bottomShareView];

}

- (void)addHeadImage
{
    UserInfoEntity *userInfo ;
    userInfo = [[GloubleProperty sharedInstance] currentUserEntity];
    int sex = [userInfo.UI_sex intValue];
    NSString *defaultPhoto = @"default_photo_males.png";
    if (sex == 0) {
        defaultPhoto = @"default_photo_females.png";
    }
    NSString *baseUrl = SERVICE_URL;

    NSString *urlString = [baseUrl stringByAppendingString:userInfo.UI_photoPath];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 20, 42, 42)];
    self.headImgView.layer.cornerRadius = 21;
    self.headImgView.layer.masksToBounds = YES;
    [self.headImgView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultPhoto]];

    [self.backPicImgView addSubview:self.headImgView];
}

- (void)addUserName
{
    UserInfoEntity *userInfo ;
    userInfo = [[GloubleProperty sharedInstance] currentUserEntity];
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 150, 22)];
    nameLab.text = userInfo.UI_nickname;
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    nameLab.textColor = [UIColor blackColor];
    [self.backPicImgView addSubview:nameLab];
}

- (void)addTime
{
    NSString *dateStr = [[NSDate date] convertToStandardYYYYMMDDDateFormat];
    int month1 = [[dateStr substringWithRange:NSMakeRange(5, 1)] intValue];
    int month2 = [[dateStr substringWithRange:NSMakeRange(6, 1)] intValue];
    int day1 = [[dateStr substringWithRange:NSMakeRange(8, 1)] intValue];
    int day2 = [[dateStr substringWithRange:NSMakeRange(9, 1)] intValue];

    UIImage *targetImage = self.backPicImgView.image;
    targetImage = [targetImage imageWithStringWaterMark:[NSString stringWithFormat:@"%d%d月%d%d日",month1,month2,day1,day2] atPoint:CGPointMake(477,3) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:30]];
    [self.backPicImgView setImage:targetImage];
}

- (void)MyRyFit
{
    UIImage *targetImage = self.backPicImgView.image;
    targetImage = [targetImage imageWithStringWaterMark:@"我的RyFit指数为             分" atPoint:CGPointMake(40,136) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:48]];
    [self.backPicImgView setImage:targetImage];
}

- (void)RyFitValue
{
    UserInfoEntity *userInfo ;
    userInfo = [[GloubleProperty sharedInstance] currentUserEntity];
    UserDataEntity *userData = userInfo.UI_lastUserData;
    CGFloat ryfit = [CalculateTool calculateRyFitWithUserInfo:userInfo data:userData];
    if (ryfit>0&&ryfit<100) {
        UIImage *targetImage = self.backPicImgView.image;
        targetImage = [targetImage imageWithStringWaterMark:[NSString stringWithFormat:@"%.1f",ryfit] atPoint:CGPointMake(390,105) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:85]];
        [self.backPicImgView setImage:targetImage];
    }
}

- (void)addPeopleImageView
{

}

- (void)suggest
{
    UserInfoEntity *userInfo ;
    userInfo = [[GloubleProperty sharedInstance] currentUserEntity];
    int sex = [userInfo.UI_sex intValue];
    if (sex == 0) {//女
        float femalesStandardWeight = ([userInfo.UI_height intValue]-70)*0.6;
        float f1 = femalesStandardWeight-[userInfo.UI_weight floatValue];
        //标准
        if (-1.0<=f1&&f1<=1.0) {
            UIImage *targetImage = self.backPicImgView.image;
            targetImage = [targetImage imageWithStringWaterMark:@"你身材那么好," atPoint:CGPointMake(160,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
            [self.backPicImgView setImage:targetImage];

            UIImage *targetImage2 = self.backPicImgView.image;
            targetImage2 = [targetImage2 imageWithStringWaterMark:@"家里人知道吗？" atPoint:CGPointMake(160,719) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
            [self.backPicImgView setImage:targetImage2];

            UIImage *logoimage = [UIImage imageNamed:@"standardFemale.png"];
            //UIImage *logoimage = self.headImgView.image;
            UIImage *targetImagePeople = self.backPicImgView.image;
            targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
            [self.backPicImgView setImage:targetImagePeople];

        }
        //瘦
        else if (femalesStandardWeight-[userInfo.UI_weight floatValue]>1.0) {
            float ca = femalesStandardWeight-[userInfo.UI_weight floatValue];
            NSString *str1 = [NSString stringWithFormat:@"看着韩剧吃%.1f次",ca*13.0];
            NSString *str2 = [NSString stringWithFormat:@"吃%.1f份爱心便当",ca*8.0];
            NSString *str3 = [NSString stringWithFormat:@"吃%.1f层楼高的泡面",ca*0.5];

            NSMutableArray *arr = [NSMutableArray arrayWithObjects:str1,str2,str3, nil];
            NSString *lastObject = arr[arc4random()%3];

            if ([lastObject isEqualToString:str1]) {
                UIImage *targetImage = self.backPicImgView.image;
                targetImage = [targetImage imageWithStringWaterMark:str1 atPoint:CGPointMake(150,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:50]];
                [self.backPicImgView setImage:targetImage];

                UIImage *targetImage2 = self.backPicImgView.image;
                targetImage2 = [targetImage2 imageWithStringWaterMark:@"“炸鸡和啤酒”" atPoint:CGPointMake(170,719) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:50]];
                [self.backPicImgView setImage:targetImage2];
            }else{

                UIImage *targetImage = self.backPicImgView.image;
                targetImage = [targetImage imageWithStringWaterMark:lastObject atPoint:CGPointMake(68,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
                [self.backPicImgView setImage:targetImage];
            }

            if ([lastObject isEqualToString:str1]) {
                UIImage *logoimage = [UIImage imageNamed:@"zhengfei6.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(600卡路里/1份)" atPoint:CGPointMake(158,770) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastObject isEqualToString:str2]){
                UIImage *logoimage = [UIImage imageNamed:@"zhengfei4.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(900卡路里/1份)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastObject isEqualToString:str3]){
                UIImage *logoimage = [UIImage imageNamed:@"zhengfei2.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(470卡路里/一碗)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];
            }


        }
        //胖
        else if ([userInfo.UI_weight floatValue]-femalesStandardWeight>1.0) {
            float ca = [userInfo.UI_weight floatValue]-femalesStandardWeight;
            NSString *str1 = [NSString stringWithFormat:@"疯狂shopping%.1f个小时",ca*42.0];
            NSString *str2 = [NSString stringWithFormat:@"梳妆打扮%.1f个小时",ca*111.0];
            NSString *str3 = [NSString stringWithFormat:@"在梦里神游%.1f个小时",ca*160.0];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:str1,str2,str3, nil];
            NSString *lastObject = arr[arc4random()%3];

            if ([lastObject isEqualToString:str1]) {
                UIImage *targetImage = self.backPicImgView.image;
                targetImage = [targetImage imageWithStringWaterMark:str1 atPoint:CGPointMake(48,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
                [self.backPicImgView setImage:targetImage];
            }else{

                UIImage *targetImage = self.backPicImgView.image;
                targetImage = [targetImage imageWithStringWaterMark:lastObject atPoint:CGPointMake(60,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
                [self.backPicImgView setImage:targetImage];
            }
            if ([lastObject isEqualToString:str1]) {
                UIImage *logoimage = [UIImage imageNamed:@"jianfei4.png"];
                //UIImage *logoimage = self.headImgView.image;
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(182卡路里/小时)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastObject isEqualToString:str2]){
                UIImage *logoimage = [UIImage imageNamed:@"jianfei3.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(69卡路里/小时)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastObject isEqualToString:str3]){
                UIImage *logoimage = [UIImage imageNamed:@"jianfei1.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(48卡路里/小时)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }

        }

    }else if (sex == 1) {
        float malesStandardWeight = ([userInfo.UI_height intValue]-80)*0.7;
        float f1 = malesStandardWeight-[userInfo.UI_weight floatValue];
        //标准
        if (-1.0<=f1&&f1<=1.0)
        {
            UIImage *targetImage = self.backPicImgView.image;
            targetImage = [targetImage imageWithStringWaterMark:@"你身材那么好," atPoint:CGPointMake(160,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
            [self.backPicImgView setImage:targetImage];

            UIImage *targetImage2 = self.backPicImgView.image;
            targetImage2 = [targetImage2 imageWithStringWaterMark:@"家里人知道吗？" atPoint:CGPointMake(160,719) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
            [self.backPicImgView setImage:targetImage2];

            UIImage *logoimage = [UIImage imageNamed:@"standard.png"];
            //UIImage *logoimage = self.headImgView.image;
            UIImage *targetImagePeople = self.backPicImgView.image;
            targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
            [self.backPicImgView setImage:targetImagePeople];

        }
        //瘦
        else if (malesStandardWeight-[userInfo.UI_weight floatValue]>1.0) {
            float ca = malesStandardWeight-[userInfo.UI_weight floatValue];
            NSString *str1 = [NSString stringWithFormat:@"吞下%.1f公斤切糕",ca*5.7];
            NSString *str2 = [NSString stringWithFormat:@"吃垮%.1f家麦当劳店",ca*0.09];
            NSString *str3 = [NSString stringWithFormat:@"点%.1f份“主席套餐”",ca*5.0];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:str1,str2,str3, nil];//[NSMutableArray arrayWithObjects:str1,str2,str3, nil];
            NSString *lastStr = arr[arc4random()%3];

            UIImage *targetImage = self.backPicImgView.image;
            targetImage = [targetImage imageWithStringWaterMark:lastStr atPoint:CGPointMake(68,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
            [self.backPicImgView setImage:targetImage];
            if ([lastStr isEqualToString:str1]) {
                UIImage *logoimage = [UIImage imageNamed:@"zhengfei5.png"];
                //UIImage *logoimage = self.headImgView.image;
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(136卡路里/100g)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastStr isEqualToString:str2]){
                UIImage *logoimage = [UIImage imageNamed:@"zhengfei3.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(450卡路里/个)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastStr isEqualToString:str3]){
                UIImage *logoimage = [UIImage imageNamed:@"zhengfei1.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(1500卡路里/1份)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }


        }
        //胖
        else if ([userInfo.UI_weight floatValue]-malesStandardWeight>1.0) {
            float ca = [userInfo.UI_weight floatValue]-malesStandardWeight;
            NSString *str1 = [NSString stringWithFormat:@"%.1f个小时吉他",ca*77.0];
            NSString *str2 = [NSString stringWithFormat:@"跳%.1f个小时的草裙舞",ca*26.0];
            NSString *str3 = [NSString stringWithFormat:@"被狗追着跑%.1f个小时",ca*57.0];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:str1,str2,str3, nil];
            NSString *lastStr = arr[arc4random()%3];

            if ([lastStr isEqualToString:str1]) {
                UIImage *targetImage = self.backPicImgView.image;
                targetImage = [targetImage imageWithStringWaterMark:@"在女生楼下弹" atPoint:CGPointMake(130,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
                [self.backPicImgView setImage:targetImage];

                UIImage *targetImage2 = self.backPicImgView.image;
                targetImage2 = [targetImage2 imageWithStringWaterMark:str1 atPoint:CGPointMake(110,719) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
                [self.backPicImgView setImage:targetImage2];

            }else{

                UIImage *targetImage = self.backPicImgView.image;
                targetImage = [targetImage imageWithStringWaterMark:lastStr atPoint:CGPointMake(68,669) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:55]];
                [self.backPicImgView setImage:targetImage];
            }

            if ([lastStr isEqualToString:str1]) {
                UIImage *logoimage = [UIImage imageNamed:@"lose Weight3.png"];
                //UIImage *logoimage = self.headImgView.image;
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(100.5卡路里/小时)" atPoint:CGPointMake(110,775) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastStr isEqualToString:str2]){
                UIImage *logoimage = [UIImage imageNamed:@"lose Weight1.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(300卡路里/小时)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }else if ([lastStr isEqualToString:str3]){
                UIImage *logoimage = [UIImage imageNamed:@"lose Weight2.png"];
                UIImage *targetImagePeople = self.backPicImgView.image;
                targetImagePeople = [targetImagePeople imageWithWaterMask:logoimage inRect:CGRectMake(118, 225, 404, 404)];
                [self.backPicImgView setImage:targetImagePeople];

                UIImage *targetImageKa = self.backPicImgView.image;
                targetImageKa = [targetImageKa imageWithStringWaterMark:@"(134卡路里/小时)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:19.0/255.0 green:118.0/255.0 blue:222.0/255.0 alpha:1] font:[UIFont systemFontOfSize:35]];
                [self.backPicImgView setImage:targetImageKa];

            }

        }

    }



}

- (void)addWantReachPerfectYouNeed
{
    UIImage *logoimage = [UIImage imageNamed:@"xuyao.png"];
    //UIImage *logoimage = self.headImgView.image;
    UIImage *targetImage = self.backPicImgView.image;
    targetImage = [targetImage imageWithWaterMask:logoimage inRect:CGRectMake(45, 437, 169, 238)];
    [self.backPicImgView setImage:targetImage];
}


- (void)kaLuLi
{
    //    UIImage *targetImage = self.backPicImgView.image;
    //    targetImage = [targetImage imageWithStringWaterMark:@"(300卡/小时)" atPoint:CGPointMake(158,744) color:[UIColor colorWithRed:0 green:1 blue:1 alpha:1] font:[UIFont systemFontOfSize:35]];
    //    [self.backPicImgView setImage:targetImage];

}

#pragma mark - Action methods

- (void)weChatBtnAction:(id)sender
{
    UIGraphicsBeginImageContext(self.backPicImgView.size); //currentView 当前的view
    [self.backPicImgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //[[ShareEngine sharedInstance] sendWeChatMessageWithType:weChat];
    [[ShareEngine sharedInstance] sendWeChatMessageWithType:weChat sendImage:viewImage];
    
    [Flurry logEvent:@"分享" withParameters:@{@"微信按钮":@"分享到微信"} timed:YES];

}


- (void)friendBtnAction:(id)sender
{
    UIGraphicsBeginImageContext(self.backPicImgView.size); //currentView 当前的view
    [self.backPicImgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[[ShareEngine sharedInstance] sendWeChatMessageWithType:weChatFriend];
    [[ShareEngine sharedInstance] sendWeChatMessageWithType:weChatFriend sendImage:viewImage];
    
    [Flurry logEvent:@"分享" withParameters:@{@"朋友圈按钮":@"分享到微信朋友圈"} timed:YES];
}

- (void)sinaBtnAction:(id)sender
{
    if (NO == [[ShareEngine sharedInstance] isLogin:sinaWeibo])
    {
        [[ShareEngine sharedInstance] loginWithType:sinaWeibo];

    }
    else
    {
        UIGraphicsBeginImageContext(self.backPicImgView.size); //currentView 当前的view
        [self.backPicImgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        [[ShareEngine sharedInstance] sendShareMessage:@"分享图片" shareImage:viewImage WithType:sinaWeibo];
        
        [Flurry logEvent:@"分享" withParameters:@{@"微博按钮":@"分享到sina微博"} timed:YES];

    }

}

#pragma mark - shareEngineDelegate

- (void)shareEngineDidLogIn:(ShareType)weibotype
{

}

- (void)shareEngineDidLogOut:(ShareType)weibotype
{

}

- (void)shareEngineSendSuccess
{

    [self showHUDInWindowJustWithText:@"分享成功" disMissAfterDelay:1];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (void)shareEngineSendFail:(NSError *)error
{
    NSLog(@"send error");
    NSString *failDescription = @"请重试！";
    if (20019 == error.code)
    {
        failDescription = @"重复发送了相同的内容！";
    }
    UIAlertView *shareAlert = [[UIAlertView alloc] initWithTitle:@"发送失败" message:failDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [shareAlert show];
}





#pragma mark - manager memory methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
