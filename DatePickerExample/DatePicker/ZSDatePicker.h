//
//  ZSDatePicker.h
//  DocSite
//
//  Created by MrXia on 16/10/17.
//  Copyright © 2016年 com.yixuejie.DocSite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSPickerModel.h"

@protocol ZSDatePickerDelegate <NSObject>

@optional;
- (void)pickerViewSelectedWithModel:(ZSPickerModel *)pickerModel;
- (void)dismissPickerWithCompleted:(BOOL)compltete;

@end

@interface ZSDatePicker : UIView

/** 初始化选定的时间 */
@property (nonatomic, strong) NSDate *date;

- (instancetype)initWithFrame:(CGRect)frame pickerStyle:(ZSDatePickerStyle )pickerStyle delegate:(id<ZSDatePickerDelegate>)delegate;
- (void)show;
- (void)cancel;

@end
