//
//  ZSPickerModel.m
//  DocSite
//
//  Created by MrXia on 16/10/17.
//  Copyright © 2016年 com.yixuejie.DocSite. All rights reserved.
//

#import "ZSPickerModel.h"

@interface ZSPickerModel ()

@property (nonatomic, assign) ZSDatePickerMode pickerMode;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *hourArray;
@property (nonatomic, strong) NSMutableArray *minuteArray;
@property (nonatomic, strong) NSMutableArray *secondArray;

@end

@implementation ZSPickerModel

+ (NSMutableArray *)modelWithPickerMode:(ZSDatePickerMode )pickerMode {
    ZSPickerModel *pickerModel = [[ZSPickerModel alloc]initWithPickerMode:pickerMode];
    return [pickerModel getDataArray];
}

+ (ZSPickerModel *)modelWithComponent:(NSInteger)compoment row:(NSInteger)row mode:(ZSDatePickerMode )pickerMode pickerModel:(ZSPickerModel *)pickerModel{
    NSMutableArray *dataArray = [pickerModel getDataArray];
    NSArray *componentArray = dataArray[compoment];
    switch (pickerMode) {
        case ZSDatePickerModeDateAndTime:{
            switch (compoment) {
                case 0:
                    pickerModel.year = componentArray[row];
                    break;
                case 1:
                    pickerModel.month = componentArray[row];
                    break;
                case 2:
                    pickerModel.day = componentArray[row];
                    break;
                case 3:
                    pickerModel.hour = componentArray[row];
                    break;
                case 4:
                    pickerModel.minute = componentArray[row];
                    break;
                default:
                    break;
            }
        }
            break;
        case ZSDatePickerModeDate: {
            switch (compoment) {
                case 0:
                    pickerModel.year = componentArray[row];
                    break;
                case 1:
                    pickerModel.month = componentArray[row];
                case 2:
                    pickerModel.day = componentArray[row];
                default:
                    break;
            }
        }
        case ZSDatePickerModeTime: {
            switch (compoment) {
                case 0:
                    pickerModel.hour = componentArray[row];
                    break;
                case 1:
                    pickerModel.minute = componentArray[row];
                case 2:
                    pickerModel.second = componentArray[row];
                default:
                    break;
            }
        }
        default:
            break;
    }
    return pickerModel;
}

- (instancetype)initWithPickerMode:(ZSDatePickerMode )pickerMode {
    if (self = [super init]) {
        self.pickerMode = pickerMode;
    }
    return self;
}

- (NSMutableArray *)getDataArray {
    return self.dataArray;
}


+ (NSArray *)getDaysComponentArrayWithDays:(NSInteger)days {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < days; i++) {
        NSString *day = [NSString stringWithFormat:@"%ld日",1 + i];
        [array addObject:day];
    }
    return array;
}

+ (NSArray *)getDetailDateNumber:(NSDate *)date {
    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    long day=[comps day];
    long year=[comps year];
    long month=[comps month];
    long hour=[comps hour];
    long minute=[comps minute];
    long second=[comps second];
    
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    [dateArray addObject:@(year - 2000)];
    [dateArray addObject:@(month -1)];
    [dateArray addObject:@(day -1)];
    [dateArray addObject:@(hour)];
    [dateArray addObject:@(minute)];
    [dateArray addObject:@(second)];
    return dateArray;
}

+ (NSInteger)getDaysInYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    if(year % 4 > 0) {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

- (NSString *)descrition {
    NSDictionary *dic= @{@"year":self.year,@"month":self.month,@"day":self.day,@"hour":self.hour,@"minute":self.minute,@"second":self.second};
    return [NSString stringWithFormat:@"<%@ : %p,\"%@\">",[self class],self,dic];
}

#pragma mark - 懒加载
- (NSMutableArray *)yearArray {
    if (_yearArray == nil) {
        _yearArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 51; i++) {
            NSString *year = [NSString stringWithFormat:@"%ld年", (long)i];
            if (i < 10) {
                year = [NSString stringWithFormat:@"0%ld年", (long)i];
            }
            [_yearArray addObject:year];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (_monthArray == nil) {
        _monthArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 12; i++) {
            NSString *month = [NSString stringWithFormat:@"%ld月",1 + i];
            [_monthArray addObject:month];
        }
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (_dayArray == nil) {
        _dayArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 31; i++) {
            NSString *day = [NSString stringWithFormat:@"%ld日",1 + i];
            [_dayArray addObject:day];
        }
    }
    return _dayArray;
}

- (NSMutableArray *)hourArray {
    if (_hourArray == nil) {
        _hourArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 25; i++) {
            NSString *hour = [NSString stringWithFormat:@"%ld",i];
            [_hourArray addObject:hour];
        }
    }
    return _hourArray;
}

- (NSMutableArray *)minuteArray {
    if (_minuteArray == nil) {
        _minuteArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 60; i++) {
            NSString *minute = [NSString stringWithFormat:@"%ld",i];
            if (i < 10) {
                minute = [NSString stringWithFormat:@"0%ld",i];
            }
            [_minuteArray addObject:minute];
        }
    }
    return _minuteArray;
}

- (NSMutableArray *)secondArray {
    if (_secondArray == nil) {
        _secondArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 60; i++) {
            NSString *second = [NSString stringWithFormat:@"%ld",i];
            [_secondArray addObject:second];
        }
    }
    return _secondArray;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
        if (self.pickerMode == ZSDatePickerModeDateAndTime) {
            [_dataArray addObject:self.yearArray];
            [_dataArray addObject:self.monthArray];
            [_dataArray addObject:self.dayArray];
            [_dataArray addObject:self.hourArray];
            [_dataArray addObject:self.minuteArray];
        } else if (self.pickerMode == ZSDatePickerModeDate) {
            [_dataArray addObject:self.yearArray];
            [_dataArray addObject:self.monthArray];
            [_dataArray addObject:self.dayArray];
        } else if (self.pickerMode == ZSDatePickerModeTime) {
            [_dataArray addObject:self.hourArray];
            [_dataArray addObject:self.minuteArray];
            [_dataArray addObject:self.secondArray];
        }
    }
    return _dataArray;
}

@end
