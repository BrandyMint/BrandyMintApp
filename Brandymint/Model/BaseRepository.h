//
//  BaseRepository.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "ABMultiton.h"
#import "ABMultitonProtocol.h"

@interface BaseRepository : NSObject <ABMultitonProtocol>

@property (retain, nonatomic, readonly) NSArray *entitiesBuffer;

-(NSManagedObjectContext*) managerContext;
-(BOOL)saveData;
-(NSArray*) getAllEntities;

-(Entity *) findEntityByKey: (NSString *)key;
-(Entity *) findOrCreateEntityByKey: (NSString *)key;
-(void) deleteEntity:(Entity *)entity;

@end
