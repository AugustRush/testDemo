//
//  NetworkReach.m
//  Dtouching
//
//  Created by lyywhg on 12-5-12.
//  Copyright (c) 2012年 BH. All rights reserved.
//

#import "NetworkReach.h"
#import "Reachability.h"

@interface NetworkReach()

@property (nonatomic, retain) Reachability *hostReach;
@property (nonatomic, retain) Reachability *internetReach;
@property (nonatomic, retain) Reachability *wifiReach;
@property (nonatomic, retain) BBAlertView  *networkAlert;

- (void)updateInterfaceWithReachability:(Reachability *)curReach;

@end

/*********************************************************************/

@implementation NetworkReach

@synthesize isNetReachable = _isNetReachable;
@synthesize isHostReach = _isHostReach;
@synthesize isInternetReach = _isInternetReach;
@synthesize isWifiReach = _isWifiReach;

@synthesize hostReach = _hostReach;
@synthesize internetReach = _internetReach;
@synthesize wifiReach = _wifiReach;
@synthesize networkAlert = _networkAlert;
@synthesize reachableCount = _reachableCount;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_hostReach);
    TT_RELEASE_SAFELY(_internetReach);
    TT_RELEASE_SAFELY(_wifiReach);
    TT_RELEASE_SAFELY(_networkAlert);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark Reachability


- (void)initNetwork
{
    _isNetReachable = NO;
    
    _isHostReach= NO;
    
    _isInternetReach= NO;
    
    _isWifiReach= NO;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification object: nil];
    
    _hostReach = [[Reachability reachabilityWithHostName:kNetworkTestAddress] retain];
    [_hostReach startNotifier];
    
    _internetReach = [[Reachability reachabilityForInternetConnection] retain];
    [_internetReach startNotifier];
    
    _wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
    [_wifiReach startNotifier];
    
    [self updateInterfaceWithReachability:nil];
}

- (void)reachabilityChanged: (NSNotification*)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)curReach
{
    DLog(@"\n ======Reachable======= \n wifiReach = <%d> \n internetReach = <%d> \n hostReach = <%d> \n NetReachable = <%d> \n =========end========== \n",
         
         [self isWifiReach],[self isInternetReach],[self isHostReach],[self isNetReachable]);
    
    _reachableCount++;
    
    if (([self isWifiReach] || [self isInternetReach] || [self isHostReach] ) == NO && _reachableCount > 3)
    {
        [self showNetworkAlertMessage];
    }
}

-(BOOL)isNetReachable
{
    _isNetReachable = self.isWifiReach || self.isInternetReach || self.isHostReach;
    
    return _isNetReachable;
}

-(BOOL)isWifiReach
{
    _isWifiReach = [_wifiReach currentReachabilityStatus] != NotReachable;
    return _isWifiReach;
}

- (BOOL)isInternetReach
{
    _isInternetReach = [_internetReach currentReachabilityStatus] != NotReachable;
    
    return _isInternetReach;
}

- (BOOL)isHostReach
{
    _isHostReach = [_hostReach currentReachabilityStatus] != NotReachable;
    
    return _isHostReach;
}

- (BBAlertView *)networkAlert
{
    if (!_networkAlert) {
        _networkAlert = [[BBAlertView alloc] initWithTitle:L(@"警告")
                                                   message:L(@"网络不可连")
                                                  delegate:nil
                                         cancelButtonTitle:L(@"确定")
                                         otherButtonTitles:nil];
        [_networkAlert setCancelBlock:^{
            [self setNetworkAlert:nil];
        }];
    }
    return _networkAlert;
}

- (void)showNetworkAlertMessage
{
    if (![self.networkAlert isVisible]) {
        [self.networkAlert show];
    }
}

@end
