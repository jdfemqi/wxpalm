//
//  PopularOptionsCollectionCell.h
//  wxpalm
//
//  Created by qiujian on 16/3/30.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  热门选项

#import <UIKit/UIKit.h>

@interface PopularOptionsCollectionCell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UIImageView* _image;     // 图标
@property(nonatomic,weak)IBOutlet UILabel* _labMotif;     // 主题

@end
