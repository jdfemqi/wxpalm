//
//  UIComboBox.m
//  wxpalm
//
//  Created by qiujian on 16/4/11.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "UIComboBox.h"

@implementation UIComboBox

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


#import "UIComboBox.h"
#import "UIButton+CCButton.h"
#import "CCComboBoxDelegate.h"

@interface CCComboBox (Private)

- (void)showOrHidden:(BOOL)hidden;
- (void)fadeIn;
- (void)fadeOut;

@end

@implementation CCComboBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _currentRow = 0;
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        isHidden = YES;
        _button = [[UIButton alloc] initWithNormalImage:nil andHighLighted:nil frame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, frame.size.width/18.0);
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

/*重新加载数据*/
- (void) setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    if (_dataArray.count > 0) {
        if (_delegate) {
            [_delegate selected:self atIndex:0];
        }
        [_button setTitle:[_dataArray objectAtIndex:0] forState:UIControlStateNormal];
    }
    /*重置_tableView大小*/
    if (_tableView) {
        CGRect originalFrame = _tableView.frame;
        _tableView.frame = CGRectMake(originalFrame.origin.x, originalFrame.origin.y, originalFrame.size.width, _dataArray.count > _rowMaxLines ? ROW_HEIGHT *_rowMaxLines : ROW_HEIGHT * _dataArray.count);
        [_tableView reloadData];
    }
    
}

#pragma mark - UIButton
- (void)setComboBoxBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [_button setBackgroundImage:image forState:state];
}

- (void)setComboBoxFrame:(CGRect)frame
{
    self.frame = frame;
    _button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (id)getComboBoxSelectedItem
{
    return [_dataArray objectAtIndex:_currentRow];
}

/*设置弹出框大小*/
#pragma mark - UITableView
- (void)setComboBoxShowMaxLine:(NSUInteger)count
{
    _rowMaxLines = count;
    if (_tableView) {
        CGRect originalFrame = _tableView.frame;
        _tableView.frame = CGRectMake(originalFrame.origin.x, originalFrame.origin.y, originalFrame.size.width, _dataArray.count > _rowMaxLines ? ROW_HEIGHT *_rowMaxLines : ROW_HEIGHT * _dataArray.count);
    }
}

#pragma mark - UIButtonDelegate
- (void)clickAction:(id)sender
{
    if (!_tableView) {
        CGRect buttonRect = [_button convertRect:_button.bounds toView:[[UIApplication sharedApplication] keyWindow]];
        _rowMaxLines = _rowMaxLines == 0 ? ROWLINE : _rowMaxLines;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(buttonRect.origin.x, buttonRect.origin.y + buttonRect.size.height + 1, buttonRect.size.width, _dataArray.count > _rowMaxLines ? ROW_HEIGHT * _rowMaxLines : ROW_HEIGHT * _dataArray.count) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [[UIColor grayColor] CGColor];
        _tableView.layer.cornerRadius = 5;
        
        _overlayView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.1];
    }
    [self showOrHidden:(isHidden = !isHidden)];
}

#pragma mark - UITableViewDataDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_button setTitle:[_dataArray objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    if (_delegate && _currentRow != [indexPath row]) {
        [_delegate selected:self atIndex:[indexPath row]];
    }
    _currentRow = [indexPath row];
    [self showOrHidden:(isHidden = !isHidden)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] % 1 == 0) {
        //cell.backgroundColor = [UIColor grayColor];
    }
}

/*判断是否添加弹出框*/
#pragma mark - private
- (void)showOrHidden:(BOOL)hidden
{
    if (hidden) {
        [self fadeOut];
    }else {
        UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
        [keywindow addSubview:_overlayView];
        [keywindow addSubview:_tableView];
        [self fadeIn];
    }
}

- (void)fadeIn
{
    _tableView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    _tableView.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        _tableView.alpha = 1;
        _tableView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

/*动画*/
- (void)fadeOut
{
    [UIView animateWithDuration:.15 animations:^{
        _tableView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        _tableView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            [_tableView removeFromSuperview];
        }
    }];
}

@end