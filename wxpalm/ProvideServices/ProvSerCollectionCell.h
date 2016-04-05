//
//  ProvSerCollectionCell.h
//  wxpalm
//
//  Created by qiujian on 16/3/29.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvSerCollectionCell : UICollectionViewCell

@property(nonatomic,weak) NSString* _strKey;                // 主key
@property(nonatomic,weak)IBOutlet UIImageView *ivPSCell;     // 图标
@property(nonatomic,weak)IBOutlet UILabel *_labMotif;     // 主题

@end
