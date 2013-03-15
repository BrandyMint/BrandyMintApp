//
//  Bloc.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Bloc.h"
#import "BlocsRepository.h"
#import "NSDate+external.h"
#import "ImageToDataTransformer.h"

@implementation Bloc

@dynamic content;
@dynamic icon_url;
@dynamic icon;
@dynamic title;
@dynamic position;
@dynamic updated_at;


+ (void)initialize {
    if (self == [Bloc class]) {
        ImageToDataTransformer *transformer = [[ImageToDataTransformer alloc] init];
        [NSValueTransformer setValueTransformer:transformer forName:@"ImageToDataTransformer"];
    }
}

+(Bloc *)createFromDictionary:(NSDictionary*)dict
{
    Bloc *bloc = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Bloc"
                  inManagedObjectContext:[[BlocsRepository sharedRepository] managerContext]];
    
    bloc.position = [NSNumber numberWithInteger:[[dict objectForKey:@"position"] integerValue]];
    bloc.title = [dict objectForKey:@"title"];
    bloc.content = [dict objectForKey:@"content"];
    bloc.updated_at = [NSDate parseDateFromString:[dict objectForKey:@"updated_at"]];
    bloc.icon_url = [dict objectForKey:@"icon_url"];
    
    return bloc;
}

@end
