//
//  PasswdUtil.m
//  SubookDRM
//
//  Created by 两元鱼 on 8/25/12.
//  Copyright (c) 2012 FFLtd. All rights reserved.
//

#import "PasswdUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

// PBEWITHMD5andDES算法默认盐，长度为8个字节，数据可配置，
// 需要和服务端保持一致
#define kPBEDefaultSalt     @"sn201209" 

// 口令和盐摘要迭代次数,可配置，
// 需要和服务端保持一致
#define MD5_ITERATIONS_NUM  50
static void FixKeyLengths(CCAlgorithm algorithm, NSMutableData *keyData, NSMutableData *ivData);

@implementation PasswdUtil

+ (NSString *)encryptData:(NSData *)data forUser:(NSString *)userID
{
    
    if (!data || !userID) 
    {
        return nil;
    }
    
    NSData *encryptedData = nil;    
    
    // 使用PBE算法进行加密，其中，userID为口令，kPBEDefaultSalt为默认盐
    encryptedData = [self encryptPBEData:data usingPwd:userID withSalt:kPBEDefaultSalt];
    
    return [self hexStringForData:encryptedData];
}

+ (NSString *)decryptData:(NSData *)data forUser:(NSString *)userID
{
    if (!data || !userID) 
    {
        return nil;
    }
    
    NSData *decryptedData = nil;
    
    // 使用PBE算法进行解密，其中，userID为口令，kPBEDefaultSalt为默认盐
    decryptedData = [self decryptPBEData:data usingPwd:userID withSalt:kPBEDefaultSalt];
    
    NSString *plainText = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    return plainText;
}

#pragma mark -
#pragma mark PBE
+ (NSData *)encryptPBEData:(NSData *)data usingPwd:(NSString *)pwd withSalt:(NSString *)salt
{    
    
    NSData *pwdData = [pwd dataUsingEncoding:NSUTF8StringEncoding];
    NSData *saltData = [salt dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t md5[CC_MD5_DIGEST_LENGTH];
    memset(md5, 0, CC_MD5_DIGEST_LENGTH);
    
    CC_MD5_CTX ctx;
    CC_MD5_Init(&ctx);
    CC_MD5_Update(&ctx, [pwdData bytes], [pwdData length]);
    CC_MD5_Update(&ctx, [saltData bytes],[saltData length]);
    CC_MD5_Final(md5, &ctx);
    
    int i = 0;
    while (++i < MD5_ITERATIONS_NUM) 
    {
        CC_MD5(md5, CC_MD5_DIGEST_LENGTH, md5);
    }
    
    NSData *key = [NSData dataWithBytes:md5 length:CC_MD5_DIGEST_LENGTH];
    
    unsigned char iv[kCCBlockSizeDES];
    memcpy(iv, md5 + (CC_MD5_DIGEST_LENGTH/2), sizeof(iv));
    NSData *civ = [NSData dataWithBytes:iv length:kCCBlockSizeDES];
    
	NSData *result = [self encryptedUsingAlgorithm:kCCAlgorithmDES
                                                   data:data
                                                    key:key
                                   initializationVector:civ
                                                options:kCCOptionPKCS7Padding];
	
	if (result != nil)
    {
        return result;
    }
			
	return nil;
}

+ (NSData *)decryptPBEData:(NSData *)data usingPwd:(NSString *)pwd withSalt:(NSString *)salt
{
    
    NSData *pwdData = [pwd dataUsingEncoding:NSUTF8StringEncoding];
    NSData *saltData = [salt dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t md5[CC_MD5_DIGEST_LENGTH];
    memset(md5, 0, CC_MD5_DIGEST_LENGTH);
    
    CC_MD5_CTX ctx;
    CC_MD5_Init(&ctx);
    CC_MD5_Update(&ctx, [pwdData bytes], [pwdData length]);
    CC_MD5_Update(&ctx, [saltData bytes],[saltData length]);
    CC_MD5_Final(md5, &ctx);
    
    int i = 0;
    while (++i < MD5_ITERATIONS_NUM) 
    {
        CC_MD5(md5, CC_MD5_DIGEST_LENGTH, md5);
    }
    
    NSData *key = [NSData dataWithBytes:md5 length:CC_MD5_DIGEST_LENGTH];
    
    unsigned char iv[kCCBlockSizeDES];
    memcpy(iv, md5 + (CC_MD5_DIGEST_LENGTH/2), sizeof(iv));
    NSData *civ = [NSData dataWithBytes:iv length:kCCBlockSizeDES];
    
	NSData *result = [self decryptedDataUsingAlgorithm:kCCAlgorithmDES
                                                    data:data
                                                    key:key
                                   initializationVector:civ
                                                options:kCCOptionPKCS7Padding];
	
	if (result != nil)
    {
        return result;
    }
	
	return nil;

}

+ (NSData *)encryptedUsingAlgorithm:(CCAlgorithm)algorithm
                               data:(NSData *)data
                                key:(id)key
               initializationVector:(id)iv
                            options:(CCOptions)options
{
	CCCryptorRef cryptor = NULL;
	CCCryptorStatus status = kCCSuccess;
	
	NSParameterAssert([key isKindOfClass: [NSData class]] || [key isKindOfClass: [NSString class]]);
	NSParameterAssert(iv == nil || [iv isKindOfClass: [NSData class]] || [iv isKindOfClass: [NSString class]]);
	
	NSMutableData *keyData, *ivData;
	if ([key isKindOfClass: [NSData class]])
    {
        keyData = (NSMutableData *)[key mutableCopy];
    }
	else
    {
		keyData = [[key dataUsingEncoding: NSUTF8StringEncoding] mutableCopy];
    }
	
	if ([iv isKindOfClass: [NSString class]])
    {
		ivData = [[iv dataUsingEncoding: NSUTF8StringEncoding] mutableCopy];
    }
	else
    {
		ivData = (NSMutableData *)[iv mutableCopy];	// data or nil
    }
		
	// ensure correct lengths for key and iv data, based on algorithms
	FixKeyLengths(algorithm, keyData, ivData);
	
	status = CCCryptorCreate(kCCEncrypt, algorithm, options,
                             [keyData bytes], [keyData length], [ivData bytes],
                             &cryptor);
	
	if (status != kCCSuccess)
	{

		return nil;
	}
	
	NSData * result = [self runCryptor:cryptor withData:data];
	
	CCCryptorRelease(cryptor);
	
	return result;
}

+ (NSData *)decryptedDataUsingAlgorithm:(CCAlgorithm)algorithm
                                   data:(NSData *)data
                                    key:(id)key		// data or string
                   initializationVector:(id)iv		// data or string
                                options:(CCOptions)options
{
	CCCryptorRef cryptor = NULL;
	CCCryptorStatus status = kCCSuccess;
	
	NSParameterAssert([key isKindOfClass: [NSData class]] || [key isKindOfClass: [NSString class]]);
	NSParameterAssert(iv == nil || [iv isKindOfClass: [NSData class]] || [iv isKindOfClass: [NSString class]]);
	
	NSMutableData *keyData, *ivData;
	if ([key isKindOfClass: [NSData class]])
    {
		keyData = (NSMutableData *) [key mutableCopy];
    }
	else
    {
		keyData = [[key dataUsingEncoding: NSUTF8StringEncoding] mutableCopy];
    }
	
	if ([iv isKindOfClass: [NSString class]])
    {
		ivData = [[iv dataUsingEncoding: NSUTF8StringEncoding] mutableCopy];
    }
	else
    {
		ivData = (NSMutableData *)[iv mutableCopy];	// data or nil
    }
		
	// ensure correct lengths for key and iv data, based on algorithms
	FixKeyLengths(algorithm, keyData, ivData);
	
	status = CCCryptorCreate(kCCDecrypt, algorithm, options,
                             [keyData bytes], [keyData length], [ivData bytes],
                             &cryptor);
	
	if ( status != kCCSuccess )
	{

		return nil;
	}
	
	NSData *result = [self runCryptor:cryptor withData:data];
	
	CCCryptorRelease(cryptor);
	
	return result;
}

+ (NSData *)runCryptor:(CCCryptorRef)cryptor withData:(NSData *)data
{
    CCCryptorStatus status = kCCSuccess;
    
	size_t bufsize = CCCryptorGetOutputLength(cryptor, (size_t)[data length], true);
    
	void *buf = malloc(bufsize);
    
	size_t bufused = 0;
    size_t bytesTotal = 0;
    
	status = CCCryptorUpdate(cryptor, [data bytes], (size_t)[data length], 
                             buf, bufsize, &bufused);
    
	if (status != kCCSuccess)
	{
		free(buf);
		return nil;
	}
    
    bytesTotal += bufused;
	
	// From Brent Royal-Gordon (Twitter: architechies):
	//  Need to update buf ptr past used bytes when calling CCCryptorFinal()
	status = CCCryptorFinal(cryptor, buf + bufused, bufsize - bufused, &bufused);
	if (status != kCCSuccess)
	{
		free(buf);
		return nil;
	}
    
    bytesTotal += bufused;
	
	return [NSData dataWithBytesNoCopy:buf length:bytesTotal];
}

static void FixKeyLengths(CCAlgorithm algorithm, NSMutableData *keyData, NSMutableData *ivData)
{
	NSUInteger keyLength = [keyData length];
    
	switch (algorithm)
	{
		case kCCAlgorithmAES128:
		{
			if (keyLength <= 16)
			{
				[keyData setLength: 16];
			}
			else if (keyLength <= 24)
			{
				[keyData setLength: 24];
			}
			else
			{
				[keyData setLength: 32];
			}
			
			break;
		}
			
		case kCCAlgorithmDES:
		{
			[keyData setLength: 8];
			break;
		}
			
		case kCCAlgorithm3DES:
		{
			[keyData setLength: 24];
			break;
		}
			
		case kCCAlgorithmCAST:
		{
			if (keyLength <= 5)
			{
				[keyData setLength: 5];
			}
			else if (keyLength >= 16)
			{
				[keyData setLength: 16];
			}
			
			break;
		}
			
		case kCCAlgorithmRC4:
		{
			if (keyLength >= 512)
				[keyData setLength: 512];
			break;
		}
			
		default:
			break;
	}
	
	[ivData setLength: [keyData length]];
}

#pragma mark -
#pragma mark Hex Convert
+ (NSString *)hexStringForData:(NSData *)data
{
    if (data == nil)
    {
        return nil;
    }
    
    NSMutableString *hexString = [NSMutableString string];
    
    const unsigned char *p = [data bytes];
    
    for (int i=0; i < [data length]; i++) 
    {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return [hexString uppercaseString];
}

+ (NSData *)dataForHexString:(NSString *)hexString
{
    if (hexString == nil)
    {
        return nil;
    }
    
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) 
    {
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') 
        {
            byte = *ch - '0';
        }
        else if ('a' <= *ch && *ch <= 'f') 
        {
            byte = *ch - 'a' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) 
        {
            if ('0' <= *ch && *ch <= '9') 
            {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') 
            {
                byte += *ch - 'a' + 10;
            }
            ch++;
        }
        
        [data appendBytes:&byte length:1];
    }
    
    return data;
}

@end
