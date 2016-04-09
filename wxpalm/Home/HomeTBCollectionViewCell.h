//
//  HomeTBCollectionViewCell.h
//  wxpalm
//
//  Created by qiujian on 16/3/15.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HomeTBCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) NSString* _strKey;
@property(nonatomic,weak) NSString* _strMotifBackGroundImage;
@property(nonatomic,weak)IBOutlet UILabel *lbHomeTBCell;
@property(nonatomic,weak)IBOutlet UIImageView *ivHomeTBCell;

-(void)updateView:(NSMutableDictionary*)dicTemp;

@end
