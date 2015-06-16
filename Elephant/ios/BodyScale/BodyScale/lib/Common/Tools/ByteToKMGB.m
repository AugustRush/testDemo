//
//  ByteToKMGB.m
//  FFLtd
//
//  Created by 两元鱼 on 12-11-20.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "ByteToKMGB.h"

@implementation ByteToKMGB

+ (float)isGB:(unsigned long long)byte
{    
    return (byte >> 30);
}

+ (float)isMB:(unsigned long long)byte
{
    return (byte >> 20);
}

+ (float)isKB:(unsigned long long)byte
{
    return (byte >> 10);
}

+ (NSString *)Volumn:(unsigned long long)byte
{
    unsigned long long igb = [ByteToKMGB isGB:byte];
    unsigned long long imb = [ByteToKMGB isMB:byte];
    unsigned long long ikb = [ByteToKMGB isKB:byte];
    
    if (igb != 0)
    {
        double fmb = (imb - igb * 1024) / 1024.0;
        NSString *GBString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fGB",(igb+fmb)]];
        return GBString;
    }
    else if (imb != 0)
    {
        double fkb = (ikb - imb * 1024) / 1024.0;
        NSString *MBString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fMB",(imb+fkb)]];
        return MBString;
    }
    else if (ikb != 0)
    {
        float fb = (byte - ikb * 1024) / 1024.0;
        NSString *KBString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fKB",(ikb+fb)]];
        return KBString;
    }
    else 
    {
        float fbyte = (float)byte;
        NSString *BString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fB",fbyte]];
        return BString;
    }
    return @"0B";
}

@end
