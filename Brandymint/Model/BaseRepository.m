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

static BaseRepository *sharedSingleton = NULL;

//+ (void)initialize
//{
//    static BOOL initialized = NO;
//    if(!initialized)
//    {
//        initialized = YES;
//        sharedSingleton = [[MySingleton alloc] init];
//    }
//}
//
+(BaseRepository *) sharedRepository
{
    @synchronized(self) {
        if(sharedSingleton == NULL) {
            NSLog(@"BasesRepository init");
            sharedSingleton = [[self.class alloc] init];
        }
    }
    return (sharedSingleton);
}

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
        
        NSString *message = nil;
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
    [request setEntity:entityDescriptor];
    
    //NSPredicate* pred = [NSPredicate predicateWithFormat:@"order == 1"];
    //[request setPredicate:pred];
    
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

//
//#pragma mark Methods for get first cards from repository
//
//-(Card*) getFirstCard
//{
//    if( cardsBuffer == nil || cardsBuffer.count == 0) {
//        NSLog(@"Error in CardsRepository. cardsBuffer = nil");
//        return nil;
//    }
//    
//    NSLog(@"get first card");
//    return [cardsBuffer objectAtIndex:0];
//}
//
//#pragma mark Methods for get next cards from repository
//
//-(Card*) getNextCard:(Card*)prevCard
//{
//    if( cardsBuffer == nil) {
//        NSLog(@"Error in CardsRepository (getNextCard). cardsBuffer = nil");
//        return nil;
//    }
//    
//    NSInteger index = [cardsBuffer indexOfObject:prevCard];
//    if(index == NSNotFound) {
//        NSLog(@"Error in CardsRepository (getNextCard). indexOfObject = nil");
//        return nil;
//    }
//    
//    index += 1;
//    if( index >= cardsBuffer.count )  {
//        NSLog(@"Warning in CardsRepository (getNextCard). index out of range");
//        return nil;
//    }
//    
//    return [cardsBuffer objectAtIndex:index];
//}
//
//#pragma mark Methods for get previous cards from repository
//
//-(Card*) getPreviousCard:(Card*)prevCard
//{
//    if( cardsBuffer == nil) {
//        NSLog(@"Error in CardsRepository (getPreviousCard). cardsBuffer = nil");
//        return nil;
//    }
//    
//    NSInteger index = [cardsBuffer indexOfObject:prevCard];
//    if(index == NSNotFound) {
//        NSLog(@"Error in CardsRepository (getPreviousCard). indexOfObject = nil");
//        return nil;
//    }
//    
//    index -= 1;
//    if( index < 0 )  {
//        NSLog(@"Warning in CardsRepository (getPreviousCard). index out of range");
//        return nil;
//    }
//    
//    return [cardsBuffer objectAtIndex:index];
//}

-(void) deleteEntity:(NSManagedObject *)entity
{
    [[[self.class sharedRepository] managerContext] deleteObject:entity];
}


@end
