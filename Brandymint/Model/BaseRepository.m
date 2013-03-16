//
//  BaseRepository.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "BaseRepository.h"
#import "AppDelegate.h"


@implementation BaseRepository


@synthesize entitiesBuffer;

// http://stackoverflow.com/questions/145154/what-should-my-objective-c-singleton-look-like


-(id) init
{
    self = [super init];
    if(self)
    {
        [self getAllEntities];
    }
    return self;
}

#pragma mark -
#pragma mark Get database manager context
-(NSManagedObjectContext*) managerContext
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

#pragma mark -
#pragma mark Save context
- (BOOL)saveData {
    NSError *error;
    if (![[self managerContext] save:&error]) {
        
        if ([[error domain] isEqualToString:@"NSCocoaErrorDomain"]) {
            
            NSDictionary *userInfo = [error userInfo];
            if ([userInfo valueForKey:@"NSDetailedErrors"] != nil) {
                
                NSArray *errors = [userInfo valueForKey:@"NSDetailedErrors"];
                for (NSError *anError in errors) {
                    
                    NSDictionary *subUserInfo = [anError userInfo];
                    subUserInfo = [anError userInfo];
                    
                    NSLog(@"Core Data Save Error\n\n \
                          NSValidationErrorKey\n%@\n\n \
                          NSValidationErrorPredicate\n%@\n\n \
                          NSValidationErrorObject\n%@\n\n \
                          NSLocalizedDescription\n%@",
                          [subUserInfo valueForKey:@"NSValidationErrorKey"],
                          [subUserInfo valueForKey:@"NSValidationErrorPredicate"],
                          [subUserInfo valueForKey:@"NSValidationErrorObject"],
                          [subUserInfo valueForKey:@"NSLocalizedDescription"]);
                }
            }
            
            else {
                NSLog(@"Core Data Save Error\n\n \
                      NSValidationErrorKey\n%@\n\n \
                      NSValidationErrorPredicate\n%@\n\n \
                      NSValidationErrorObject\n%@\n\n \
                      NSLocalizedDescription\n%@",
                      [userInfo valueForKey:@"NSValidationErrorKey"],
                      [userInfo valueForKey:@"NSValidationErrorPredicate"],
                      [userInfo valueForKey:@"NSValidationErrorObject"],
                      [userInfo valueForKey:@"NSLocalizedDescription"]);
                
            }
        }
        else {
            NSLog(@"Custom Error: %@", [error localizedDescription]);
        }
        return NO;
    }
    return YES;
}

-(NSArray*) getAllEntities
{
    NSManagedObjectContext *context = [self managerContext];
    
    NSEntityDescription *entityDescriptor = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortByPosition = [[NSSortDescriptor alloc]
                                        initWithKey:@"position"
                                        ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects: sortByPosition, nil];

    [request setSortDescriptors: sortDescriptors];
    [request setEntity:entityDescriptor];
    
    NSError *error;
    entitiesBuffer = [context executeFetchRequest:request error:&error];
    
    if(entitiesBuffer == nil)
    {
        NSLog(@"Error while reading %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        return nil;
    }
    
    return entitiesBuffer;
}

-(NSString *) entityName {
    return @"Card"; // TODO abastract
}

-(Entity *) findEntityByKey: (NSString *)key
{
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"key == %@", key];
    
    [fetch setEntity:[NSEntityDescription entityForName:self.entityName inManagedObjectContext:[self managerContext]]];
    [fetch setPredicate:pred];
    
    NSArray * found_entities = [[self managerContext] executeFetchRequest:fetch error:nil];
    
    return found_entities.count>0 ? [found_entities objectAtIndex:0] : nil;
    
}

-(Entity *) findOrCreateEntityByKey: (NSString *)key
{
    Entity *entity = [self findEntityByKey:key];
    
    if (!entity) {
        entity = [NSEntityDescription
                  insertNewObjectForEntityForName:self.entityName
                  inManagedObjectContext:self.managerContext];
    }
    
    return entity;
}

-(void) deleteEntity:(Entity *)entity
{
    [[self managerContext] deleteObject:entity];
}


@end
