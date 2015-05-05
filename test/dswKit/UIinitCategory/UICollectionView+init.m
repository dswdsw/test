//
//  UICollectionView+init.m
//  YMXK
//
//  Created by stephen on 15/5/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UICollectionView+init.h"

@implementation UICollectionView (init)



-(void)registerNibClass:(Class) nibclass forCellWithReuseIdentifier:(NSString *)identifier
{
    id nib=   [UINib nibWithNibName:NSStringFromClass(nibclass) bundle:nil];
    
    [self  registerNib: nib forCellWithReuseIdentifier:identifier];
}
@end
