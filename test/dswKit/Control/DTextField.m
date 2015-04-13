//
//  DTextField.m
//  dswkitTest
//
//  Created by stephen on 15/4/7.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DTextField.h"
#import "NSString+quick.h"

@implementation DTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initTb];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self initTb];
    
}

-(void)initTb
{
    self.delegate=self;
    
    if (self.number) {
        self.keyboardType=UIKeyboardTypeNumberPad;
    }

}


-(NSString *)validationMeg
{
    
    if (self.required) {
        if (!self.text.length>0) {
            return self.fieldName.add(@"必填");
        }
    }
    
    
    if (self.minLength!=0) {
        if (self.text.length<self.minLength) {
            return self.fieldName.add(@"至少").add(@(self.minLength)).add(@"位");
        }
    }
    
    
    if (self.number) {
        if (self.min!=0) {
            if ([self.text floatValue]<self.min) {
                return self.fieldName.add(@"需大于").add(@(self.min));
            }
        }
        if (self.max!=0) {
            if ([self.text floatValue]>self.max) {
                return self.fieldName.add(@"需小于").add(@(self.max));
            }
        }
    }
    
    return nil;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.maxLength!=0) {
        if (self.text.length<self.maxLength) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
     return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
     return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     return YES;
}




@end
