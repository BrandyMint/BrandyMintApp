//
//  Card.h
//  Brandymint
//
//  Created by Danil Pismenny on 12.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ImageToDataTransformer.h"

@class Card;

@interface Card : NSManagedObject

@property (nonatomic, retain) UIImage  *image;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *link;

@end
