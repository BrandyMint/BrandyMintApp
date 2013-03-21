//
//  Entity.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Entity.h"
#import "NSDate+external.h"
#import "Image.h"

@implementation Entity

@dynamic key;

-(void)setSmartValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]) {
        [self setValue:nil forKey:key];
        // TODO Определять по типу property, а не названию
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:[NSDate parseDateFromString:value] forKey:key];
    } else {
        [self setValue:value forKey:key];
    }
}

-(void)updateFromDict:(NSDictionary* )entity_dict
{
    // TODO Делать наоборот- Проходиться по всем свойствам entity и брать их из Directory.
    [entity_dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, id value, BOOL *stop) {
        [self setSmartValue:value forKey:key];
    }];
}


@end
