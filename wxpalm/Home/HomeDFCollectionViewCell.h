//
//  HomeDFCollectionViewCell.h
//  wxpalm
//
//  Created by qiujian on 16/3/16.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeTBCellMotif             @"motif"            // 主题
#define HomeTBCellBriefDes          @"briefDes"         // 简要描述
#define HomeTBCellIconName          @"iconName"         // 图标名称
#define HomeTBCellIconName2         @"iconName2"        // 副图标名
#define HomeTBCellpviewController   @"pviewController"  // 便民功能界面控制器


@interface HomeDFCollectionViewCell : UICollectionViewCell

-(void)updateView:(NSMutableDictionary*)dicTemp;
@end