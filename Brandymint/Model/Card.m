//
//  Card.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Card.h"
#import "Image.h"


@implementation Card

@dynamic desc;
@dynamic key;
@dynamic link;
@dynamic position;
@dynamic subtitle;
@dynamic title;
@dynamic updated_at;
@dynamic image;
@dynamic image_url;
@dynamic gplay_url;
@dynamic itunes_url;
@dynamic url;


- (void)didChangeValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"image_url"]) {
        Image *image = [Image findOrDownloadByUrl:self.image_url withContext:self.managedObjectContext];
        [self setValue:image forKey:@"image"];
    }
    [super didChangeValueForKey:key];
}

@end
