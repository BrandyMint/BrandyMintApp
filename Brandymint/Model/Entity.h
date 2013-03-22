//
//  Entity.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * key;

-(void)updateFromDict:(NSDictionary* )dict;

@end
