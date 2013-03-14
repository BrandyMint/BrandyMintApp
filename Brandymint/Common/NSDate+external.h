//
//  NSDate+external.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 14.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISO8610)

+(NSDate*) parseDateFromString:(NSString*)dateString;

@end
