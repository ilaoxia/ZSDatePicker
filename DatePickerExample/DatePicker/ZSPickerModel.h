//
//  ZSPickerModel.h
//  DocSite
//
//  Created by MrXia on 16/10/17.
//  Copyright © 2016年 com.yixuejie.DocSite. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ZSDatePickerMode) {
    ZSDatePickerModeDate,          ///年月日
    ZSDatePickerModeTime,          ///时分秒
    ZSDatePickerModeDateAndTime    ///年月日时分
};

@interface ZSPickerModel : NSObject

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;

- (instancetype)initWithPickerMode:(ZSDatePickerMode )pickerMode;
+ (NSMutableArray *)modelWithPickerMode:(ZSDatePickerMode )pickerMode;
+ (ZSPickerModel *)modelWithComponent:(NSInteger)compoment row:(NSInteger)row mode:(ZSDatePickerMode )pickerMode pickerModel:(ZSPickerModel *)pickerModel;
+ (NSArray *)getDaysComponentArrayWithDays:(NSInteger)days;
+ (NSArray *)getDetailDateNumber:(NSDate *)date;
+ (NSInteger)getDaysInYear:(NSInteger)year withMonth:(NSInteger)month;

@end
