/*!
 @header
 @abstract 常用公共资源的constant类，主要用于存放公共组件的rect或者公共图片的imageName；
 @author   两元鱼
 @version  1.0  2013/3/18 Creation
 */
 

//=================================常用资源名信息==============================//

#pragma mark - Common ImageName 
#pragma mark   常用图片名

#define kNavigationBarBackgroundImage       @"Navgation.png"
#define kNavControllerBackgroundImage       @"home_system_background.png"

//=================================常用提示信息===============================//
#pragma mark -  UserInfo Alert Message
#pragma mark    用户可见提示信息

//"系统信息"
#define kSystemInfo                 L(@"system-info")
//"确定"
#define kConfirm                    L(@"Confirm")
//"取消"
#define kCancel                     L(@"Cancel")

//"在非wifi网络环境下上传/下载会产生数据流量费用"
#define kUserInfo_WifiNotReachable  L(@"UserInfo_WifiNotReachable")
//"网络异常，没有可以使用的网络"
#define kUserInfo_NetWorkNotReachable  L(@"UserInfo_NetWorkNotReachable")


//=================================常用错误信息===============================//
#pragma mark -  Common Error
#pragma mark    常用的错误信息
//系统错误相关




#pragma mark -  Common Request Error
#pragma mark    常用的数据请求错误信息
//请求失败
#define kError_NormalRequestError             L(@"Error_NormalRequestFail")
//"文件下载失败"
#define kError_FileDownloadFail               L(@"Error_FileDownloadFail")
//"文件URL为空，文件位置不存在"
#define kError_FileDownloadURLNull            L(@"kError_FileDownloadURLNull")
//"文件上传地址获取失败"
#define kError_FileUploadURLFail               L(@"Error_FileUploadURLFail")
//"文件上传失败"
#define kError_FileUploadFail                  L(@"Error_FileUploadFail")
//"上传文件本地副本为空，文件上传失败"
#define kError_FileUploadFail_LocalPath_NULL   L(@"Error_FileUploadFail_LocalPath_NULL")
//"上传文件为空或文件损坏"
#define kError_FileUploadFail_File_BROKEN      L(@"Error_FileUploadFail_File_BROKEN")
//"上传文件本地地址有无法删除的同名文件"
#define kError_FileUploadFail_File_CONFLICT      L(@"Error_FileUploadFail_File_CONFLICT")
//"上传文件类型未别，上传失败"
#define kError_FileUploadFail_File_NOVALIDE      L(@"Error_FileUploadFail_File_NOVALIDE")
//"上传文件本地保存失败"
#define kError_FileLocalFail_ORIFile_UNSAVE      L(@"Error_FileLocalFail_ORIFile_UNSAVE")
//"上传文件缩略图本地保存失败"
#define kError_FileLocalFail_THUMBFile_UNSAVE    L(@"Error_FileLocalFail_THUMBFile_UNSAVE")
//"文件删除失败"
#define kError_FileLocalFail_DeleteFail          L(@"Error_FileLocalFail_DeleteFail")
//"本地文件不存在"
#define kError_FileDeleteFail_NotExist           L(@"Error_FileDeleteFail_NotExist")

//===============================常用Request请求==============================//

#pragma mark -  Common Request Action
#pragma mark    常用Request请求

#define ActionArea_File                         @"files"
#define ActionArea_Login                        @"login"
#define ActionArea_Regist                       @"register"
#define ActionArea_VCode                        @"scode"
#define ActionArea_ClientLogin                  @"clientLogin"
#define ActionArea_ClientLogout                 @"clientLogout"
#define ActionArea_Register                     @"register"

#define ActionArea_Version                      @"version"
#define ActionArea_Upgrate                      @"upgrade"

#define FolderActionArea                        @"folder"
#define SafeBoxActionArea                       @"box"

#define Action_DownLoad                         @"download"
#define Action_UpLoad                           @"upload"
#define Action_Capacity                         @"space"
#define Action_UserCapacity                     @"userCenter"

#define CreateAction                            @"create"
#define UpdateAction                            @"update"
#define MoveAction                              @"move"
#define DestroyAction                           @"destory"
#define TrashAction                             @"trash"
#define RecoveryAction                          @"recovery"

#define FileListAction                          @"list"
#define FileListDestDirAction                   @"listDestDir"
#define FileUpdateAction                        @"update"
#define FileMoveAction                          @"move"
#define FileDestoryAction                       @"destory"
#define FileSearchAction                        @"search"
#define FileTypeAction                          @"type"
#define FileRecycleAction                       @"recycle"
#define FileTrashAction                         @"trash"
#define FileRecoveryAction                      @"recovery"
#define FileListDestDirAction                   @"listDestDir"

#define SafeBoxCheckAction                      @"check"
#define SafeBoxSetAction                        @"setpwd"

//===============================常用接口宏定义==============================//

#define FolderCreateServiceAction         1001
#define FolderUpdateServiceAction         1002
#define FolderMoveServiceAction           1003
#define FolderDestroyServiceAction        1004
#define FolderTrashServiceAction          1005
#define FolderRecoverServiceAction        1006
#define FileRecoveryServiceAction         2001
#define FileTrashServiceAction            2002
#define FileRecycleServiceAction          2003
#define FileTypeServiceAction             2004
#define FileSearchServiceAction           2005
#define FileDestoryServiceAction          2006
#define FileMoveServiceAction             2007
#define FileUpdateServiceAction           2008
#define FileListServiceAction             2009
#define FileDownloadServiceAction         2010
#define FileListDestDirServiceAction      2011
#define SafeBoxSetServiceAction           3002
#define SafeBoxLoginServiceAction         3003
#define FileRefreshListServiceAction      4001
#define FileRefreshTypeListServiceAction  4002
#define FileRefreshListDestDirServiceAction 4003











