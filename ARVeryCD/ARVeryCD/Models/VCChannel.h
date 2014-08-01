//
//  VCChannel.h
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights


#import <Mantle.h>

@interface VCChannel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *chanelId;
@property (nonatomic, copy) NSString *channelDescription;
@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *channelThumbnail;

@end
