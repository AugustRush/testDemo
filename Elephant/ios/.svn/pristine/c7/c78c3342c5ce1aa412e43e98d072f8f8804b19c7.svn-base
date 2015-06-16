//
//  DocumentsManage.m
//  DZB
//
//  Created by 两元鱼 on 14/6/25.
//  Copyright (c) 2014年 FFLtd. All rights reserved.
//

#import "DocumentsManage.h"

@implementation DocumentsManage

+ (BOOL)createFolder:(NSString *)pathString
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathString] == NO)
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}
+ (BOOL)clearOneFolder:(NSString *)pathString
{
     if ([[NSFileManager defaultManager] fileExistsAtPath:pathString] == YES)
     {
         return [[NSFileManager defaultManager] removeItemAtPath:pathString error:nil];
     }
    return NO;
}
+ (BOOL)clearCacheFiles
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:TmpDocumentPath] == YES)
    {
        return [[NSFileManager defaultManager] removeItemAtPath:TmpDocumentPath error:nil];
    }
    return NO;
}

+ (BOOL)createLocalTimeFolder
{
//    NSString *currentTime = [[NSString alloc] init];
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:pathString] == NO)
//    {
//        return [[NSFileManager defaultManager] createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    return NO;
}

+ (void)initAllAppNeedFolders
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:TmpDocumentPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:TmpDocumentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:TmpLocalDataPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:TmpLocalDataPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:HiddenPhotoPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:HiddenPhotoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:UploadFilesPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:UploadFilesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:DownloadFilesPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:DownloadFilesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:DatabaseDataPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:DatabaseDataPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:TmpFolderPath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:TmpFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (double)getFreeDiskspace
{
    double totalSpace = 0.0f;
    double totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        DLog(@"Memory Capacity of %f MiB with %f MiB Free memory available.", ((totalSpace/1024.0f)/1024.0f), ((totalFreeSpace/1024.0f)/1024.0f));
    }
    else
    {
        DLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalFreeSpace;
}

+ (NSMutableArray *)getOneFolderAllFilesAndFolders:(NSString *)oneFolderPath
{
    NSMutableArray *tArray = [[NSMutableArray alloc] init];
    [tArray addObjectsFromArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:oneFolderPath error:nil]];
    return tArray;
}
+ (NSMutableArray *)getOneFolderAllFolders:(NSString *)oneFolderPath
{
    NSMutableArray *tArray = [[NSMutableArray alloc] init];
    [tArray addObjectsFromArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:oneFolderPath error:nil]];
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString *file in tArray)
    {
        NSString *path = [oneFolderPath stringByAppendingPathComponent:file];
        [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:(&isDir)];
        if (isDir)
        {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
    return dirArray;
}

@end