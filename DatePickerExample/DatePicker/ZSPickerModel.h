//
//  ZSPickerModel.h
//  DocSite
//
//  Created by MrXia on 16/10/17.
//  Copyright © 2016年 com.yixuejie.DocSite. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ZSDatePickerStyle) {
    ZSDatePickerStyleDate,          ///年月日
    ZSDatePickerStyleTime,          ///时分秒
    ZSDatePickerStyleDateAndTime    ///年月日时分
};

@interface ZSPickerModel : NSObject

@property (nonatomic, copy) NSString *year;   ///年
@property (nonatomic, copy) NSString *month;  ///月
@property (nonatomic, copy) NSString *day;    ///日
@property (nonatomic, copy) NSString *hour;   ///时
@property (nonatomic, copy) NSString *minute; ///分
@property (nonatomic, copy) NSString *second; ///秒
@property (nonatomic, strong) NSDate *date;   ///获取选定的的时间date

- (instancetype)initWithPickerStyle:(ZSDatePickerStyle )pickerStyle;
+ (NSMutableArray *)modelWithPickerStyle:(ZSDatePickerStyle )pickerStyle;
+ (ZSPickerModel *)modelWithComponent:(NSInteger)compoment row:(NSInteger)row style:(ZSDatePickerStyle )pickerMode pickerModel:(ZSPickerModel *)pickerModel;
+ (NSArray *)getDaysComponentArrayWithDays:(NSInteger)days;
+ (NSArray *)getDetailDateNumber:(NSDate *)date;
+ (NSInteger)getDaysInYear:(NSInteger)year withMonth:(NSInteger)month;

@end
