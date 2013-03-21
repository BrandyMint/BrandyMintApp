//
//  ThemeProvider.h
//  Brandymint
//
//  Created by DenisDbv on 21.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"

@interface ThemeProvider : NSObject

CWL_DECLARE_SINGLETON_FOR_CLASS(ThemeProvider)


-(UIFont*) boldFont:(CGFloat)pointSize;
-(UIFont*) lightFont:(CGFloat)pointSize;
-(UIFont*) italicFont:(CGFloat)pointSize;

-(UIFont*) condensedRegularFont:(CGFloat)pointSize;

@end
