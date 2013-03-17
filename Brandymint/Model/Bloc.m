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

- (void)didChangeValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"icon_url"]) {
        Image *image = [Image findOrDownloadByUrl:self.icon_url withContext:self.managedObjectContext];
        [self setValue:image forKey:@"icon"];
    }
    [super didChangeValueForKey:key];
}

@end
