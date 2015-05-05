//
//  UICollectionView+init.h
//  YMXK
//
//  Created by stephen on 15/5/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (init)

-(void)registerNibClass:(Class) nib forCellWithReuseIdentifier:(NSString *)identifier;


@end
