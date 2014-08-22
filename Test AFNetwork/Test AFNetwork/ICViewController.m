//
//  ICViewController.m
//  Test AFNetwork
//
//  Created by 刘平伟 on 14-5-1.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ICViewController.h"
#import "AFNetworking/AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "FTCoreTextView.h"


//约定串
#define APPOINT_KEY @"894D94361A243577F0A497C4EAB6462A178900022D1D95B2EAE04"

#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

static const CGFloat kBasicTextSize = 12.0f;
@interface ICViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) RACSignal *requestSignal;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) FTCoreTextView *coreTextView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *urlString = @"http://xingmawang.com/nozzle/index/tiezixiangqing";
    NSDictionary *parameter = @{@"topicid":@"258"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //设置返回格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        
        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"topic"][0]];
        
        NSString *htmlstring = [NSString stringWithString:[dataDic objectForKey:@"content"]];
        
    
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlstring dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        CGRect bounds = self.view.bounds;
        
        //  Create scroll view containing allowing to scroll the FTCoreText view
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //  Create FTCoreTextView. Everything will be rendered within this view
        self.coreTextView = [[FTCoreTextView alloc] initWithFrame:CGRectInset(bounds, 20.0f, 0) andAttributedString:attributedString];
        self.coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self.scrollView addSubview:self.coreTextView];
        [self.view addSubview:self.scrollView];

        
        
//        self.coreTextView.text = attributedString;
        
        //  Define styles
        FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc] init];
        defaultStyle.name = FTCoreTextTagDefault;
        defaultStyle.textAlignment = FTCoreTextAlignementJustified;
        defaultStyle.font = [UIFont systemFontOfSize:kBasicTextSize];
        
        FTCoreTextStyle *h1Style = [defaultStyle copy];
        h1Style.name = @"h1";
        h1Style.font = [UIFont boldSystemFontOfSize:kBasicTextSize*2.0f];
        h1Style.textAlignment = FTCoreTextAlignementCenter;
        
        FTCoreTextStyle *h2Style = [h1Style copy];
        h2Style.name = @"h2";
        h2Style.font = [UIFont boldSystemFontOfSize:kBasicTextSize*1.25];
        
        FTCoreTextStyle *pStyle = [defaultStyle copy];
        pStyle.name = @"p";
        
        //  HTML list "li" style
        //  We first get default style for "_bullet" tag, rename it to "li"
        //  and then replace the default with new tag
        FTCoreTextStyle *liStyle = [FTCoreTextStyle styleWithName:FTCoreTextTagBullet];
        liStyle.name = @"li";
        liStyle.paragraphInset = UIEdgeInsetsMake(0, 14.0f, 0, 0);
        
        [self.coreTextView changeDefaultTag:FTCoreTextTagBullet toTag:@"li"];
        
        
        //  HTML image "img" style
        //  We first get default style for "_image" tag, rename it to "img"
        //  and then replace the default with new tag
        FTCoreTextStyle *imgStyle = [FTCoreTextStyle styleWithName:FTCoreTextTagImage];
        imgStyle.name = @"img";
        imgStyle.textAlignment = FTCoreTextAlignementJustified;
        
        [self.coreTextView changeDefaultTag:FTCoreTextTagImage toTag:@"img"];
        
        
        //  HTML link anchor "a"
        //  We first get default style for "_link" tag, rename it to "a"
        //  and then replace the default with new tag
        //  Mind you still need to use "_link"-like format
        //  <a>http://url.com|Dislayed text</a> format, not the html "<a href..." format
        FTCoreTextStyle *aStyle = [FTCoreTextStyle styleWithName:FTCoreTextTagLink];
        aStyle.name = @"a";
        aStyle.underlined = YES;
        aStyle.color = [UIColor blueColor];
        
        [self.coreTextView changeDefaultTag:FTCoreTextTagLink toTag:@"a"];
        
        //  Apply styles
        [self.coreTextView addStyles:@[defaultStyle, imgStyle, h1Style, h2Style, pStyle, liStyle, aStyle]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    
    NSMutableDictionary *arr = [NSMutableDictionary dictionary]; 
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"width=" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@" " intoString:&text];
        //替换字符
        NSLog(@"text is %@",text);
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@"wdfwef"];
        
        //找到标签的起始位置
//        [scanner scanUpToString:@"width=100" intoString:nil];
//        //找到标签的结束位置
//        [scanner scanUpToString:@" " intoString:&text];
//        //替换字符
//        NSLog(@"text is %@",text);
//        
//        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@""];
    }
    
    
    return html;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //  We need to recalculate fit height on every layout because
    //  when the device orientation changes, the FTCoreText's width changes
    
    //  Make the FTCoreTextView to automatically adjust it's height
    //  so it fits all its rendered text using the actual width
	[self.coreTextView fitToSuggestedHeight];
    
    //  Adjust the scroll view's content size so it can scroll all
    //  the FTCoreTextView's content
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds), CGRectGetMaxY(self.coreTextView.frame)+20.0f)];
}

+ (NSString *)textFromTextFileNamed:(NSString *)filename
{
    NSString *name = [filename stringByDeletingPathExtension];
    NSString *extension = [filename pathExtension];
    
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:extension] encoding:NSUTF8StringEncoding error:nil];
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
//    NSString *
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.numberOfLines = 1;
    cell.textLabel.font = [UIFont systemFontOfSize:8];
    [cell.textLabel sizeToFit];

    return cell;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
//    NSURLSessionDownloadTask *downLoadTask = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:@"http://www.xingmawang.com/Addons/kindeditor/plugins/emoticons/images/52.gif"] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@\n %@\n %@",error,response,location);
//        
//        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
//        
//        CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
//        
//        CGImageRef img = CGImageSourceCreateImageAtIndex(sourceRef, 0, NULL);
//        UIImage *image = [[UIImage alloc] initWithCGImage:img];
//        NSLog(@"image size is %@",NSStringFromCGSize(image.size));
//        self.imageView.image = image;
//        
//        
//    }];
//    
//    [downLoadTask resume];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
