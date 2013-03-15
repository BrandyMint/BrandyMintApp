//
//  Card.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@interface Card : Entity

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * key;

@end
