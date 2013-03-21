//
//  BMCoreTextLabel.m
//  Brandymint
//
//  Created by Danil Pismenny on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "BMCoreTextLabel.h"
#import "NMCustomLabelStyle.h"

@implementation BMCoreTextLabel

-(void)setDefaults {
    [super setDefaults];
            
    [self setStyle:[NMCustomLabelStyle
                    styleWithFont:[[ThemeProvider sharedThemeProvider] boldFont:self.font.pointSize]
                    color:self.textColor]
            forKey:@"bold_style"];

    [self setStyle:[NMCustomLabelStyle
                    styleWithFont:[[ThemeProvider sharedThemeProvider] italicFont:self.font.pointSize]
                    color:self.textColor]
            forKey:@"ital_style"];

}


@end
