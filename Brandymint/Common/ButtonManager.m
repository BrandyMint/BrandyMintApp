//
//  ButtonManager.m
//  Brandymint
//
//  Created by DenisDbv on 19.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "ButtonManager.h"

@implementation ButtonManager

+(UIButton*) createButtonWithText:(NSString*)text
{
    UIButton* anotherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [anotherButton setTitle:text forState:UIControlStateNormal];
    
    anotherButton.titleLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:32];
    anotherButton.titleLabel.textAlignment = UITextAlignmentLeft;
    anotherButton.titleLabel.shadowColor = [UIColor blackColor];
    anotherButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    
    anotherButton.backgroundColor = [UIColor clearColor];
    
    return anotherButton;
}

@end
