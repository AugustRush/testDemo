//
//  VCChanelListEntry.h
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import <Mantle.h>

@interface VCChanelListEntry : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *thumbImageUrl;
@property (nonatomic, copy) NSString *videoName;
@property (nonatomic, copy) NSString *entryId;

@end
