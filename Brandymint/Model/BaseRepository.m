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

// http://stackoverflow.com/questions/145154/what-should-my-objective-c-singleton-look-like

-(void) showAlertWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(NSManagedObjectContext*) managerContext
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

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


-(NSArray*)entitiesBuffer {
    
    [self loadData];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: self.entityName];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"position" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    
    // Setup fetched results
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                                                 sectionNameKeyPath:nil
                                                                                                          cacheName:nil];
    //[fetchedResultsController setDelegate:self];
    NSError *error = nil;
    BOOL fetchSuccessful = [fetchedResultsController performFetch:&error];
    NSLog(@"Fetched count %lu", (unsigned long)[[fetchedResultsController fetchedObjects] count]);
    //NSAssert([[fetchedResultsController fetchedObjects] count], @"Seeding didn't work...");
    if (! fetchSuccessful) {
        [self showAlertWithError: error];
    }
    
    return  [fetchedResultsController fetchedObjects];
}

- (void)loadData
{
    // Load the object model via RestKit
    [[RKObjectManager sharedManager] getObjectsAtPath:self.restPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load complete: Table should refresh...");
        
        //[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"key"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Load failed with error: %@", error);
        
        [self showAlertWithError: error];
    }];
}

-(NSString*) restPath
{
    return [[self.entityName lowercaseString] stringByAppendingString:@"s"];
}


-(NSArray*) getAllEntities_old
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
    _entitiesBuffer = [context executeFetchRequest:request error:&error];
    
    if(_entitiesBuffer == nil)
    {
        NSLog(@"Error while reading %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        return nil;
    }
    
    return _entitiesBuffer;
}

-(NSString *) entityName {
    methodNotImplemented();
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
