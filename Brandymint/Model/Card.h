//
//  Card.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"
#import "Image.h"

@class Image;

@interface Card : Entity

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * gplay_url;
@property (nonatomic, retain) NSString * itunes_url;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) Image *image;

@end
