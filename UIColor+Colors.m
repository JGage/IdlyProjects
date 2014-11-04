//
//  UIColor+Colors.m
//  Altogether
//
//  Created by josh on 10/29/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import "UIColor+Colors.h"

@implementation UIColor (Colors)

// Basement Grey - DEMO
+ (UIColor *) DEMObasementGray {
    static UIColor *DEMObasementGrey;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ DEMObasementGrey = [UIColor colorWithWhite:0.2f alpha:1.0f]; });
    return DEMObasementGrey;
}
// Basement Grey - custom
+ (UIColor *) CONbasementGrey {
    static UIColor *idlyPaleBlue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ idlyPaleBlue = [UIColor colorWithRed: 44/255.0f green:57/255.0f blue:69/255.0f alpha:1.0]; });
    return idlyPaleBlue;
}
// Idly Blue
+ (UIColor *) CONidlyPaleBlue {
    static UIColor *idlyPaleBlue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ idlyPaleBlue = [UIColor colorWithRed: 141/255.0f green:204/255.0f blue:239/255.0f alpha:1.0]; });
    return idlyPaleBlue;
}
// Idly Pink
+ (UIColor *) CONidlyPalePink {
    static UIColor *idlyPalePink;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ idlyPalePink = [UIColor colorWithRed: 255/255.0f green:149/255.0f blue:133/255.0f alpha:1.0]; });
    return idlyPalePink;
}

@end
