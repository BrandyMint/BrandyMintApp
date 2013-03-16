//
//  BaseRepository.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface BaseRepository : NSObject
{
    NSArray *entitiesBuffer;
}

@property (retain, readonly) NSArray *entitiesBuffer;

+(BaseRepository *) sharedRepository;

-(NSManagedObjectContext*) managerContext;
-(BOOL)saveData;
-(NSArray*) getAllEntities;

-(void) deleteEntity:(NSManagedObject *)entity;
-(Entity *) findEntityByKey: (NSString *)key;
-(Entity *) findOrCreateEntityByKey: (NSString *)key;

@end
