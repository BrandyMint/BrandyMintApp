//
//  BaseRepository.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRepository : NSObject
{
    NSMutableArray *entitiesBuffer;
}

@property (retain, readonly) NSMutableArray *entitiesBuffer;

+(BaseRepository *) sharedRepository;

-(NSManagedObjectContext*) managerContext;
-(BOOL)saveData;
-(NSArray*) getAllEntities;

-(void) deleteEntity:(NSManagedObject *)entity;

@end
