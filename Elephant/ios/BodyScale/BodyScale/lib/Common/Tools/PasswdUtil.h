//
//  PasswdUtil.h
//  SubookDRM
//
//  Created by 两元鱼 on 8/25/12.
//  Copyright (c) 2012 FFLtd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface PasswdUtil : NSObject

/*!
 * @abstract
 * 给指定的密码进行加密，采用的是PBEWITHMD5andDES算法
 *
 * @discussion
 * PBEWITHMD5andDES是一种基于口令的加密算法，口令和盐需要事先和服务端约定，经过多重摘要后生成密钥
 *
 * @param data
 * 待加密的明文密码
 *
 * @param userID
 * 待登录的用户名，这里作为用户口令
 *
 * @result
 * 加密后的密文(十六进制字符串)
 */
+ (NSString *)encryptData:(NSData *)data forUser:(NSString *)userID;

/*!
 * @abstract
 * 将加密后的密码进行解密，采用的是PBEWITHMD5andDES算法
 *
 * @discussion
 * PBEWITHMD5andDES是一种基于口令的加密算法，口令和盐需要事先和服务端约定，经过多重摘要后生成密钥
 *
 * @param data
 * 经过加密后的密文
 *
 * @param userID
 * 待登录的用户名，这里作为用户口令
 *
 * @result
 * 解密后的密码明文
 */
+ (NSString *)decryptData:(NSData *)data forUser:(NSString *)userID;
+ (NSData *)runCryptor:(CCCryptorRef)cryptor withData:(NSData *)data;
+ (NSData *)encryptPBEData:(NSData *)data usingPwd:(NSString *)pwd withSalt:(NSString *)salt;
+ (NSData *)decryptedDataUsingAlgorithm:(CCAlgorithm)algorithm
                                   data:(NSData *)data
                                    key:(id)key		// data or string
                   initializationVector:(id)iv		// data or string
                                options:(CCOptions)options;
+ (NSData *)encryptedUsingAlgorithm:(CCAlgorithm)algorithm
                               data:(NSData *)data
                                key:(id)key
               initializationVector:(id)iv
                            options:(CCOptions)options;
+ (NSData *)decryptPBEData:(NSData *)data usingPwd:(NSString *)pwd withSalt:(NSString *)salt;
+ (NSString *)hexStringForData:(NSData *)data;@end
