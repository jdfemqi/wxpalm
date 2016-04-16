//
//  HydropowerPaymentViewController.m
//  wxpalm
//
//  Created by qiujian on 16/4/7.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "HydropowerPaymentViewController.h"

@interface HydropowerPaymentViewController ()
{
    __weak IBOutlet UIWebView *_wvPaymentSetting;
    __weak IBOutlet UIToolbar *_toolBar;    // 工具条
    __weak IBOutlet UIBarButtonItem *_itemWater;    // 水费
    __weak IBOutlet UIBarButtonItem *_itemPower;    // 电费
    __weak IBOutlet UIBarButtonItem *_itemGas;      // 燃气费
    UIBarButtonItem *_itemOldClick;      // 上次点击的节点
}

@end

@implementation HydropowerPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 显示水费缴费界面
    [self BarBtnItemPress:_itemWater];
    _itemOldClick = _itemWater;
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

// ToolBar中单元点击事件
-(IBAction)BarBtnItemPress:(id)sender
{
    // 点击的节点
    UIBarButtonItem *barButtonItem = sender;
    
    // 设置字体显示颜色
    [_itemOldClick setTintColor:[UIColor blackColor]];
    _itemOldClick = barButtonItem;
    [barButtonItem setTintColor:[UIColor redColor]];
    
    // 配置html
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSString *htmlPath = [basePath stringByAppendingPathComponent:@"test.html"];
    
    if (barButtonItem == _itemWater)        // 水费
    {
        htmlPath = @"https://mpos.quanminfu.com/QmfWeb/?bizName=water&channelld=100041&signature=24042286ad0ef059b4d63a338735a429ac2dde907ba3404fbd0efced7a71d804f80baaad9714034877a874a105fc97ec381bc56e762d6f79740054790786b3ef15ab011857286058bdfea510cca7c1d9946351d683b95e427182ca730dc1b4f138e7ba3703dae5809e4e86af5f6e27ffea97af959f471c03438dd95a20479134&uniqueld=111641999&customizeld=1141";
    }
    else if (barButtonItem == _itemPower)   // 电费
    {
        htmlPath = @"https://mpos.quanminfu.com/QmfWeb/?bizName=power&channelld=100041&signature=24042286ad0ef059b4d63a338735a429ac2dde907ba3404fbd0efced7a71d804f80baaad9714034877a874a105fc97ec381bc56e762d6f79740054790786b3ef15ab011857286058bdfea510cca7c1d9946351d683b95e427182ca730dc1b4f138e7ba3703dae5809e4e86af5f6e27ffea97af959f471c03438dd95a20479134&uniqueld=111641999&customizeld=1141";
    }
    else if (barButtonItem == _itemGas)     // 燃气费
    {
        htmlPath = @"https://mpos.quanminfu.com/QmfWeb/?bizName=gas&channelld=100041&signature=24042286ad0ef059b4d63a338735a429ac2dde907ba3404fbd0efced7a71d804f80baaad9714034877a874a105fc97ec381bc56e762d6f79740054790786b3ef15ab011857286058bdfea510cca7c1d9946351d683b95e427182ca730dc1b4f138e7ba3703dae5809e4e86af5f6e27ffea97af959f471c03438dd95a20479134&uniqueld=111641999&customizeld=1141";
    }
    
    // 加载html
    NSURL *url = [[NSURL alloc]initWithString:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wvPaymentSetting loadRequest:request];
}
@end
