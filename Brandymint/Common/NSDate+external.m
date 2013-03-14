//
//  NSDate+external.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 14.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "NSDate+external.h"

@implementation NSDate (ISO8610)

+(NSDate*) parseDateFromString:(NSString*)dateString
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    return [formatter dateFromString:dateString];
}

@end
