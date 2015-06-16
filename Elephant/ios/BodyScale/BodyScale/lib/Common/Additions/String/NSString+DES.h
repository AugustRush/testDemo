//
//  NSString+DES.h
//  FFLtd
//
//  Created by  两元鱼 on 12-11-15.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


@interface NSString (DES)

+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;


@end
