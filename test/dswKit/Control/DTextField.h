//
//  DTextField.h
//  dswkitTest
//
//  Created by stephen on 15/4/7.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTextField : UITextField <UITextFieldDelegate>


@property (nonatomic , strong )IBInspectable NSString*  fieldName;

#pragma  mark -

@property (nonatomic , assign )IBInspectable BOOL   required;

#pragma  mark -

@property (nonatomic , assign )IBInspectable NSInteger maxLength;

@property (nonatomic , assign )IBInspectable NSInteger minLength;

#pragma  mark -

@property (nonatomic , assign )IBInspectable BOOL   number;

@property (nonatomic , assign )IBInspectable NSInteger min;

@property (nonatomic , assign )IBInspectable NSInteger max;


-(NSString *)validationMeg;

@end
