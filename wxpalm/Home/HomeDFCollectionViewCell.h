//
//  HomeDFCollectionViewCell.h
//  wxpalm
//
//  Created by qiujian on 16/3/16.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeDFCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak) NSString* _strKey;
-(void)updateView:(NSMutableDictionary*)dicTemp;
@end
