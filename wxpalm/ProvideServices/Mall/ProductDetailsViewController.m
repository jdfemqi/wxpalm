//
//  ProductDetailsViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/28.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ProductDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *_labTip;
@property (weak, nonatomic) IBOutlet UIWebView *_webViewDetails;

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载本地html
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSString *htmlPath = [basePath stringByAppendingPathComponent:@"test.html"];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self._webViewDetails loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Web View Delegate Methods
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = [[request URL] absoluteString];
    //NSLog(@"%@",url);
    //代码中根据返回的URL或者scheme来判断处理不同逻辑
    if ([url isEqualToString:@"demo://"])
    {
        self._labTip.text = url;
    }
    return YES;
}

@end
