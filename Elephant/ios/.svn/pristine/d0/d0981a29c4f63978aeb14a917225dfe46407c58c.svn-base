//
//  sdkCall.m
//  sdkDemo
//
//  Created by qqconnect on 13-3-29.
//  Copyright (c) 2013年 qqconnect. All rights reserved.
//

#import "sdkCall.h"
#import "sdkDef.h"
#import <TencentOpenAPI/TencentMessageObject.h>

static sdkCall *g_instance = nil;
@interface sdkCall()
@property (nonatomic, retain)NSArray* permissons;
@end

@implementation sdkCall

@synthesize oauth = _oauth;
@synthesize permissons = _permissons;
@synthesize photos = _photos;
@synthesize thumbPhotos = _thumbPhotos;

+ (sdkCall *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            //g_instance = [[sdkCall alloc] init];
            g_instance = [[super allocWithZone:nil] init];
            [g_instance setPhotos:[NSMutableArray arrayWithCapacity:1]];
            [g_instance setThumbPhotos:[NSMutableArray arrayWithCapacity:1]];
        }
    }

    return g_instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self getinstance] retain];
}

+ (void)showInvalidTokenOrOpenIDMessage
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (void)resetSDK
{
    g_instance = nil;
}

- (id)init
{
    if (self = [super init])
    {
        NSString *appid = QQAPPID;
        _oauth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
        
    }
    return self;
}

- (void)tencentDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
    [_oauth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

- (void)tencentDidLogout
{
    
}


- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    BOOL incrAuthRes = [tencentOAuth incrAuthWithPermissions:permissions];
    return !incrAuthRes;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
}


- (void)getUserInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getListAlbumResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListAlbumResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getListPhotoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListPhotoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}   


- (void)checkPageFansResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCheckPageFansResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)addShareResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddShareResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)addAlbumResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddAlbumResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)uploadPicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUploadPicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)addOneBlogResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddOneBlogResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)addTopicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddTopicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)setUserHeadpicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSetUserHeadPicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getVipInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetVipInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getVipRichInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetVipRichInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)matchNickTipsResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMatchNickTipsResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getIntimateFriendsResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetIntimateFriendsResponse object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message
{
    if (nil == response
        || nil == message)
    {
        return;
    }
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              response, kResponse,
                              message, kMessage, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kResponseDidReceived object:self  userInfo:userInfo];
}

- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData
{
    
}


- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:tencentOAuth, kTencentOAuth,
                                                                        viewController, kUIViewController, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCloseWnd object:self  userInfo:userInfo];
}

- (BOOL)onTencentResp:(TencentApiResp *)resp
{
    if (nil == resp)
    {
        return NO;
    }
    
    NSArray *arrPhoto = [[resp objReq] arrMessage];
    for (id photo in arrPhoto)
    {
        if ([photo isKindOfClass:[TencentImageMessageObjV1 class]])
        {
            NSData *dataImage = [photo dataImage];
            UIImage *image = [UIImage imageWithData:dataImage];
            UIImage *thumbImage = [UIImage imageWithData:dataImage scale:0.4];
            if (nil != image)
            {
                [[self photos] addObject:image];
            }
            
            if (nil != thumbImage)
            {
                [[self thumbPhotos] addObject:thumbImage];
            }
        }
    }
   
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:resp, kTencentRespObj,nil];
    [self performSelectorOnMainThread:@selector(post:) withObject:userInfo waitUntilDone:NO];
    return YES;
}

- (void)post:(NSDictionary *)userInfo
{

    [[NSNotificationCenter defaultCenter] postNotificationName:kTencentApiResp object:self userInfo:userInfo];
}



- (BOOL)onTencentReq:(TencentApiReq *)req
{
//    if (_requestViewController)
//    {
//        if (([[[UIDevice currentDevice] systemVersion] floatValue] > 5.0))
//        {
//            [_requestViewController dismissViewControllerAnimated:NO completion:nil];
//        }
//        else
//        {
//            [_requestViewController dismissModalViewControllerAnimated:YES];
//        }
//        
//        _requestViewController = nil;
//    }
//    
//    _requestViewController = [[RequestContentViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    [_requestViewController setDataSource:[req arrMessage]];
//    [_requestViewController setReq:req];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_requestViewController];
//    
//    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentModalViewController:navController animated:YES];
    
    return YES;
}

@end
