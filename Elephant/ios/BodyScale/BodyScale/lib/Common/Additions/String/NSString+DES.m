//
//  NSString+DES.m
//  FFLtd
//
//  Created by  两元鱼 on 12-11-15.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "NSString+DES.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (DES)


+ (NSString *)doCipher:(NSString *)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt
{
	NSStringEncoding EnC = NSUTF8StringEncoding;
    
    NSMutableData * dTextIn;
    if (encryptOrDecrypt == kCCDecrypt)
	{
        dTextIn = [[NSData dataWithBase64EncodedString:sTextIn] mutableCopy];
    }
    else
	{
        dTextIn = [[sTextIn dataUsingEncoding: EnC] mutableCopy];
    }
    NSMutableData * dKey = [[sKey dataUsingEncoding:EnC] mutableCopy];
    [dKey setLength:kCCBlockSizeDES];
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    size_t movedBytes1 = 0;
    //uint8_t iv[kCCBlockSizeDES];
	//memset((void *) iv, 0x0, (size_t) sizeof(iv));
	Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    bufferPtrSize1 = ([sTextIn length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    bufferPtr1 = malloc(bufferPtrSize1 * sizeof(uint8_t));
    memset((void *)bufferPtr1, 0x00, bufferPtrSize1);
	CCCrypt(encryptOrDecrypt, // CCOperation op
			kCCAlgorithmDES, // CCAlgorithm alg
			kCCOptionPKCS7Padding, // CCOptions options
			[dKey bytes], // const void *key
			[dKey length], // size_t keyLength
			iv, // const void *iv
			[dTextIn bytes], // const void *dataIn
			[dTextIn length],  // size_t dataInLength
			(void *)bufferPtr1, // void *dataOut
			bufferPtrSize1,     // size_t dataOutAvailable
			&movedBytes1);      // size_t *dataOutMoved
    
    NSString * sResult;
    if (encryptOrDecrypt == kCCDecrypt)
	{
        sResult = [[NSString alloc] initWithData:[NSData dataWithBytes:bufferPtr1 length:movedBytes1] encoding:EnC];
    }
    else
	{
        NSData *dResult = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        sResult = [dResult base64Encoding];
    }
    free(bufferPtr1);
    return sResult;
}

/*
 DES加密
 */
+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    return [self doCipher:clearText key:key context:kCCEncrypt];
}


/**
 DES解密
 */
+ (NSString *)decryptUseDES:(NSString *)plainText key:(NSString *)key
{
    return [self doCipher:plainText key:key context:kCCDecrypt];
}
@end
