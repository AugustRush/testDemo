//
//  IPhoneFileUtil.h
//  
//
//  Created by 两元鱼 on 06/11/2012.
//  Copyright 2012 FFLtd. All rights reserved.
//



@interface IPhoneFileUtil : NSObject {

}

//获取私有文件夹路径
+ (NSString *)getPrivateDocsDir;
//检索应用程序的文档目录路径
-(NSString *) getDocumentDirectory;

//检索应用程序的文档临时目录路径
-(NSString *) getTemporaryDirectory;

//文件目录追加
-(NSString *) getAppendingPath:(NSString *)string1 pathAppending:(NSString *)string2;

//判断文件是否存在
-(BOOL)fileIsExists:(NSString *)fileName;

//将数组对象写入指定的文件
-(void)writeArrayToFile:(NSString *)filePath fileContent:(NSArray *) array;

//获取指定文件名所在document的全路径
-(NSString *)dataFilePath:(NSString *) fileName;

-(BOOL)deleteFile:(NSString *)fileName;

-(void)createFolder:(NSString *) filepath;
-(NSArray*)arrayOfFoldersInFolder:(NSString*) folder;

@end
