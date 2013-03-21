//
//  ThemeProvider.m
//  Brandymint
//
//  Created by DenisDbv on 21.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "ThemeProvider.h"
#import "AppDelegate.h"

@implementation ThemeProvider

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(ThemeProvider)


-(UIFont*) boldFont:(CGFloat)pointSize
{
    return [UIFont fontWithName:@"Ubuntu-Bold" size:pointSize];
}

-(UIFont*) lightFont:(CGFloat)pointSize
{
    return [UIFont fontWithName:@"Ubuntu-Light" size:pointSize];
}

-(UIFont*) italicFont:(CGFloat)pointSize
{
    return [UIFont fontWithName:@"Ubuntu-Italic" size:pointSize];
}

-(UIFont*) condensedRegularFont:(CGFloat)pointSize
{
    return [UIFont fontWithName:@"UbuntuCondensed-Regular" size:pointSize];
}

@end

