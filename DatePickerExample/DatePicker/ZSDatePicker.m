//
//  ZSDatePicker.m
//  DocSite
//
//  Created by MrXia on 16/10/17.
//  Copyright © 2016年 com.yixuejie.DocSite. All rights reserved.
//

#import "ZSDatePicker.h"
#import "ZSPickerModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ZSDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) ZSPickerModel *pickerModel;
@property (nonatomic, weak) id<ZSDatePickerDelegate> delegate;
@property (nonatomic, assign) ZSDatePickerStyle pickerStyle;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIPickerView   *picker;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGRect oldFrame;

@end

@implementation ZSDatePicker

- (instancetype)initWithFrame:(CGRect)frame pickerStyle:(ZSDatePickerStyle )pickerStyle delegate:(id<ZSDatePickerDelegate>)delegate {
    if (self = [super init]) {
        self.frame       = frame;
        self.oldFrame    = frame;
        self.delegate    = delegate;
        self.pickerStyle = pickerStyle;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    CGRect frame = CGRectMake(0, 40, WIDTH, self.bounds.size.height - 40);
    self.picker = [[UIPickerView alloc]initWithFrame:frame];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self addSubview:self.picker];
    
    
    CGFloat btnW = 50, btnH = 35, width = self.bounds.size.width;
    UIView *topView = [[UIView alloc]init];
    self.topView = topView;
    topView.frame = CGRectMake(0, 0, self.bounds.size.width, btnH);
    [self addSubview:topView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelBtn = cancelBtn;
    cancelBtn.frame = CGRectMake(5, 5, btnW, btnH - 10);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(217, 54, 57) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sureBtn = sureBtn;
    sureBtn.frame = CGRectMake(width - btnW - 5 , 5, btnW, btnH - 10);
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.backgroundColor = RGB(217, 54, 57);
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 4;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sureBtn];
}

- (void)btnClick:(UIButton *)btn {
    BOOL isComplete = NO;
    if (btn == self.cancelBtn) {
        [self cancel];
    } else {
        //确定
        isComplete = YES;
        [self cancel];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissPickerWithCompleted:)]) {
        [self.delegate dismissPickerWithCompleted:isComplete];
    }
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = self.oldFrame;
    }];
}

- (void)cancel {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)setDate:(NSDate *)date {
    _date = date;
    NSArray *dateArray = [ZSPickerModel getDetailDateNumber:date];
    [self selectedCompnentWithArray:dateArray];
    
}

- (void)selectedCompnentWithArray:(NSArray *)array {
    switch (self.pickerStyle) {
        case ZSDatePickerStyleDateAndTime:{
            for (NSInteger i = 0; i < 5; i++) {
                NSInteger row = [array[i] integerValue];
                [self.picker selectRow:row inComponent:i animated:YES];
                self.pickerModel = [ZSPickerModel modelWithComponent:i row:row style:self.pickerStyle pickerModel:self.pickerModel];
                if (i == 1) {
                    [self updateEveryMonthDaysWithRow:row inComponent:i];
                }
            }
        }
            break;
        case ZSDatePickerStyleDate:{
            for (NSInteger i = 0; i < 3; i++) {
                NSInteger row = [array[i] integerValue];
                [self.picker selectRow:row inComponent:i animated:YES];
                self.pickerModel = [ZSPickerModel modelWithComponent:i row:row style:self.pickerStyle pickerModel:self.pickerModel];
                if (i == 1) {
                    [self updateEveryMonthDaysWithRow:row inComponent:i];
                }
            }
        }
            break;
        case ZSDatePickerStyleTime:{
            for (NSInteger i = 5; i > 2; i--) {
                NSInteger row = [array[i] integerValue];
                [self.picker selectRow:row inComponent:i animated:YES];
                self.pickerModel = [ZSPickerModel modelWithComponent:i row:row style:self.pickerStyle pickerModel:self.pickerModel];
            }
        }
            break;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewSelectedWithModel:)]) {
        [self.delegate pickerViewSelectedWithModel:self.pickerModel];
    }
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *componentArray = self.dataArray[component];
    return componentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *componentArray = self.dataArray[component];
    NSString *string = componentArray[row];
    return string;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.pickerModel = [ZSPickerModel modelWithComponent:component row:row style:self.pickerStyle pickerModel:self.pickerModel];
    //根据月份获取具体天数
    [self updateEveryMonthDaysWithRow:row inComponent:component];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewSelectedWithModel:)]) {
        [self.delegate pickerViewSelectedWithModel:self.pickerModel];
    }
}

//更新每月天数
- (void)updateEveryMonthDaysWithRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerStyle != ZSDatePickerStyleTime && component == 1) {
        NSInteger year  = [self.pickerModel.year integerValue] + 2000;
        NSInteger month = [self.pickerModel.month integerValue];
        NSInteger days  = [ZSPickerModel getDaysInYear:year withMonth:month];
        NSArray *newComponentArray  = [ZSPickerModel getDaysComponentArrayWithDays:days];
        [self.dataArray replaceObjectAtIndex:component + 1 withObject:newComponentArray];
        [self.picker reloadComponent:component + 1];
    }
    
    
}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [ZSPickerModel modelWithPickerStyle:self.pickerStyle];
    }
    return _dataArray;
}

- (ZSPickerModel *)pickerModel {
    if (_pickerModel == nil) {
        _pickerModel = [[ZSPickerModel alloc]initWithPickerStyle:self.pickerStyle];
    }
    return _pickerModel;
}



@end
