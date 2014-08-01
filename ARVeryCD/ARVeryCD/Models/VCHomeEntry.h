//
//  VCHomeEntry.h
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import <Mantle.h>

@interface VCHomeEntry : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *thumbImageUrl;
@property (nonatomic, copy) NSString *videoName;
@property (nonatomic, copy) NSString *entryId;

@end

@interface VCRecommandEntry : VCHomeEntry

@end
