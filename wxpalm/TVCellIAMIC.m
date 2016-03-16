//
//  TVCellIAMIC.m
//  wxpalm
//
//  Created by qiujian on 16/3/15.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "TVCellIAMIC.h"
#import "./IAMIC.framework/Headers/IAMICObject.h"


@interface TVCellIAMIC ()
{
    IAMICObject* _iamic;
    
}

@end

@implementation TVCellIAMIC

- (void)awakeFromNib {
    // Initialization code
    
    //[super awakeFromNib];
    //self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setConfig:(UITableView *)tableView : (NSIndexPath *)indexPath
{
    // Initialization code
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"imageInfo" ofType:@"plist"];
    NSString*  _resourcePath =  [[NSBundle mainBundle]resourcePath];
    
    //CGSize szFrame = self.frame.size;
    
    // Row在tableView中的区域
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGSize szCell = rectInTableView.size;
    CGRect rc = CGRectMake(rectInTableView.origin.x, 0, szCell.width, szCell.height);
    
    _iamic = [[IAMICObject alloc]init];
    [_iamic setResourcePath:_plistPath :_resourcePath];
    [_iamic setConfigure:self.contentView :rc];
}

@end
