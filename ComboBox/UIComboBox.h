//
//  UIComboBox.h
//  wxpalm
//
//  Created by qiujian on 16/4/11.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CCButtonDelegate.h"
#define ROW_HEIGHT 30
#define ROWLINE 6

@protocol CCComboBoxDelegate;
@interface CCComboBox : UIView<UITableViewDataSource, UITableViewDelegate, CCButtonDelegate>
{
@private
    UIButton *_button;
    UITableView *_tableView;
    NSInteger _currentRow;
    NSUInteger _rowMaxLines;
    BOOL isHidden;
    UIView *_overlayView;
}
@property (assign, nonatomic) id<CCComboBoxDelegate> delegate;
@property (strong, nonatomic, setter = setDataArray:) NSMutableArray *dataArray;

- (id)initWithFrame:(CGRect)frame;
- (void)setDataArray:(NSMutableArray *)dataArray;
@end

@interface CCComboBox (UIButton)
- (void)setComboBoxBackgroundImage:(UIImage *)image forState:(UIControlState)state;
- (void)setComboBoxFrame:(CGRect)frame;
- (id)getComboBoxSelectedItem;

@end

@interface CCComboBox (UITableView)
- (void)setComboBoxShowMaxLine:(NSUInteger)count;

@end

/*ComboBox的代理*/

#import <Foundation/Foundation.h>
@class CCComboBox;
@protocol CCComboBoxDelegate <NSObject>

- (void)selected:(CCComboBox *)comboBox atIndex:(NSUInteger)index;

@end
