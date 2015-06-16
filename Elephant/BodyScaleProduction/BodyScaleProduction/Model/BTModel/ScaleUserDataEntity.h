//
//  ScaleUserDataEntity.h
//  BodyScale
//
//  Created by Go Salo on 14-2-19.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "BaseEntity.h"
#import "UserDataEntity.h"

@interface ScaleUserDataEntity : BaseEntity

@property (nonatomic)int userId;
@property (nonatomic)int pkgnum;
@property (nonatomic)int pkgid;

@property (nonatomic)NSDate *tmie;
@property (nonatomic)float weight;
@property (nonatomic)float bf;
@property (nonatomic)float water;
@property (nonatomic)float muscle;
@property (nonatomic)float bone;
@property (nonatomic)int bmr;
@property (nonatomic)float sfat;
@property (nonatomic)float infat;
@property (nonatomic)int bodyage;


- (UserDataEntity *)convertToUserDataEntityWithHeight:(float)height;

-(float)getBMIByWeight:(float)weight
                height:(float)height;
@end
