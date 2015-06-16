//
//  IPhoneFileUtil.m
//  
//
//  Created by 两元鱼 on 06/11/2012.
//  Copyright 2012 FFLtd. All rights reserved.
//

#import "IPhoneFileUtil.h"


@implementation IPhoneFileUtil


+ (NSString *)getPrivateDocsDir 
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];   
    
    return documentsDirectory;    
}

//-------------------------------------------------------------------
//方法：getDocumentDirectory
//说明：检索应用程序的文档目录路径
//时间：2009-6-11
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(NSString *) getDocumentDirectory{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex: 0 ];
	return documentDirectory;	
}

//-------------------------------------------------------------------
//方法：getTemporaryDirectory
//说明：检索应用程序的文档临时目录路径
//时间：2009-6-11
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(NSString *) getTemporaryDirectory{
	NSString *tempPath = NSTemporaryDirectory();
	return tempPath;
}


//-------------------------------------------------------------------
//方法：getAppendingPath
//说明：文件目录追加
//时间：2009-6-11
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(NSString *) getAppendingPath:(NSString *)string1 pathAppending:(NSString *)string2{
	NSString *path=[string1 stringByAppendingPathComponent:string2];	
	return path ;		
}

//-------------------------------------------------------------------
//方法：fileIsExists
//说明：判断文件是否存在
//时间：2009-6-11
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(BOOL)fileIsExists:(NSString *)filePath {
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
		return TRUE;
	}
	return FALSE;
}

//-------------------------------------------------------------------
//方法：writeArrayToFile
//说明：将数组对象写入指定的文件
//时间：2009-6-11
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(void)writeArrayToFile:(NSString *)filePath fileContent:(NSArray *) array{
	[array writeToFile:filePath atomically:YES];
}

//-------------------------------------------------------------------
//方法：dataFilePath
//说明：获取指定文件名所在document的全路径
//时间：2009-6-19
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(NSString *)dataFilePath:(NSString *) fileName {
	NSString *documentDirectory = [self getDocumentDirectory];
	NSString *path = [self getAppendingPath:documentDirectory pathAppending:fileName];
	return path;
}

//-------------------------------------------------------------------
//方法：deleteFile
//说明：删除指定的文件
//时间：2009-6-19
//作者：xihd@c-platform.com
//-------------------------------------------------------------------
-(BOOL)deleteFile:(NSString *) fileName {
	@try {
		NSFileManager *defaultManager;
		defaultManager = [NSFileManager defaultManager];
		[defaultManager removeItemAtPath:fileName error:nil];
		return TRUE;
	}
	@catch (NSException * e) {
		return FALSE;
	}
	return TRUE;
}

-(void)createFolder:(NSString *) filepath {
	
	NSFileManager *NSFm= [NSFileManager defaultManager]; 
	BOOL isDir=YES;
	
	@try {
		if(![NSFm fileExistsAtPath:filepath isDirectory:&isDir]){
			if(![NSFm createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:nil]){
				////DLog(@"Error: Create folder failed");	
			}						
		}
	} 
	@catch (id theException) {
		////DLog(@"%@", theException);
	} 
	@finally {
		////DLog(@"This always happens.");
	}
	
}



-(NSArray *)arrayOfFoldersInFolder:(NSString*) folder {
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray* files = [fm contentsOfDirectoryAtPath:folder error:nil];
	NSMutableArray *directoryList = [NSMutableArray arrayWithCapacity:10];
	
	for(NSString *file in files) {
		NSString *path = [folder stringByAppendingPathComponent:file];
		BOOL isDir = NO;
		[fm fileExistsAtPath:path isDirectory:(&isDir)];
		if(!isDir) {
			[directoryList addObject:file];
		}
	}
	
	return directoryList;
}

@end
