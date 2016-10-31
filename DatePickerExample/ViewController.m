//
//  ViewController.m
//  DatePickerExample
//
//  Created by MrXia on 16/10/31.
//  Copyright © 2016年 MrXia. All rights reserved.
//

#import "ViewController.h"
#import "ZSDatePicker.h"

@interface ViewController ()<ZSDatePickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateAndTimeLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) ZSDatePicker *datePicker;
@property (nonatomic, strong) ZSPickerModel *pickerModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)DateAndTimeStyleBtnClick:(id)sender {
    self.backView.hidden = NO;
    [self.datePicker show];
    self.datePicker.date = [NSDate date];
}

#pragma mark - ZSDatePickerDelegate
- (void)pickerViewSelectedWithModel:(ZSPickerModel *)pickerModel {
    self.pickerModel = pickerModel;
}

- (void)dismissPickerWithCompleted:(BOOL)compltete {
    self.backView.hidden = YES;
    if (compltete) {
        NSString *detail = [NSString stringWithFormat:@"%@%@%@ %@:%@",self.pickerModel.year,self.pickerModel.month,self.pickerModel.day,self.pickerModel.hour,self.pickerModel.minute];
        self.dateAndTimeLabel.text = detail;
    }
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        _backView.frame = self.view.bounds;
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.5;
        _backView.userInteractionEnabled = YES;
        [self.view addSubview:_backView];
    }
    return _backView;
}

- (ZSDatePicker *)datePicker {
    if (_datePicker == nil) {
        CGFloat pickerH = 250;
        CGRect frame = CGRectMake(0, self.view.bounds.size.height - pickerH, self.view.bounds.size.width, pickerH);
        _datePicker = [[ZSDatePicker alloc]initWithFrame:frame pickerMode:ZSDatePickerModeDateAndTime delegate:self];
        [self.view addSubview:_datePicker];
    }
    return _datePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
