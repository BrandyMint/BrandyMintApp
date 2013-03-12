//
//  Card.m
//  Brandymint
//
//  Created by Danil Pismenny on 12.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Card.h"
#import "Card.h"


@implementation Card

@dynamic image;
@dynamic title;
@dynamic subtitle;
@dynamic desc;
@dynamic url;
@dynamic link;

+ (void)initialize {
	if (self == [Card class]) {
		ImageToDataTransformer *transformer = [[ImageToDataTransformer alloc] init];
		[NSValueTransformer setValueTransformer:transformer forName:@"ImageToDataTransformer"];
	}
}
@end
