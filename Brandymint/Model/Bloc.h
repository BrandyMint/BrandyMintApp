//
//  Bloc.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bloc : Entity

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * icon_url;
@property (nonatomic, retain) UIImage  * icon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSDate * updated_at;

@end
