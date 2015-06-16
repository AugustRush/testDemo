//
//  PathConstant.h
//  reader4iphone
//
//  Created by shahsa on 13-3-18.
//  Copyright (c) 2012年 FFLtd. All rights reserved.


#import "NSStringExtension.h"

#define TmpDocumentPath                 [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@", [@"Documents" md5]]

#define TmpLocalDataPath                [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@/%@", [@"Documents" md5], [@"LocalData" md5]]
#define HiddenPhotoPath                 [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@/%@", [@"Documents" md5], [@"HiddenPhoto" md5]]
#define UploadFilesPath                 [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@/%@", [@"Documents" md5], [@"UploadFiles" md5]]
#define DownloadFilesPath               [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@/%@", [@"Documents" md5], [@"DownloadFiles" md5]]


#define DatabaseDataPath                [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%@/%@", [@"Documents" md5], [@"DataBase" md5]]


#define TmpFolderPath                   [NSTemporaryDirectory() stringByAppendingFormat:@"%@", [@"TempFolder" md5]]
