//
//  UITextField+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/10.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "UITextField+quick.h"
#import <objc/runtime.h>
#import "NSObject+quick.h"

@implementation UITextField (quick)

//
+ (instancetype)textChange:(eventBlock)block fontSize:(CGFloat)size delegate:(id<UITextFieldDelegate>)delegate placehold:(NSString *)str defaultText:(NSString *)dt fontColor:(UIColor *)color {
    UITextField *text = [UITextField new];

    [text editChange:block];
    text.font = [UIFont systemFontOfSize:size];
    text.delegate = delegate;
    text.placeholder = str;
    text.text = dt;

    if (!color) {
        color = [UIColor blackColor];
    }

    text.textColor = color;
    return text;
}

//
+ (instancetype)textField:(textFieldBlock)block {
    UITextField *text = [UITextField  new];

    block(text);
    return text;
}

//
#pragma mark - 选择时间
- (void)setInputTime {
    NSDateFormatter *formatter;

    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    UIDatePicker *picker1 = [[UIDatePicker alloc] init];
    picker1.maximumDate = [NSDate date];
    picker1.datePickerMode = UIDatePickerModeDate;
    [picker1 valueChange:^(id value) {
        self.text = [formatter stringFromDate:[picker1 date]];
    }];

    UIToolbar       *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnPicker1)];
    toolBar.items = [NSArray arrayWithObjects:flexibleSpace, right, nil];
    self.inputView = picker1;
    self.inputAccessoryView = toolBar;
}

- (void)btnPicker1 {
    [self resignFirstResponder];
}

//
#pragma mark - 选择框
static char *dropKey;

- (void)setInputDropList:(NSArray *)data {
    objc_setAssociatedObject(self, &dropKey, data, OBJC_ASSOCIATION_COPY_NONATOMIC);

    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    //    指定Delegate
    pickerView.delegate = self;
    //    显示选中框
    pickerView.showsSelectionIndicator = YES;

    UIToolbar       *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnPicker1)];
    toolBar.items = [NSArray arrayWithObjects:flexibleSpace, right, nil];
    self.inputView = pickerView;
    self.inputAccessoryView = toolBar;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *data = objc_getAssociatedObject(self, &dropKey);

    return data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *data = objc_getAssociatedObject(self, &dropKey);

    return [data[row] getString];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray *data = objc_getAssociatedObject(self, &dropKey);

    self.text = [data[row] getString];
}

//

#pragma  mark - 图标
-(void)setRightImage:(NSString *)imageName
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    self.rightView = img;
    self.rightViewMode = UITextFieldViewModeAlways;
}


-(void)setLeftImage:(NSString *)imageName;
{
     UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self setLeftView:img];
    self.leftViewMode=UITextFieldViewModeAlways;
}

@end
