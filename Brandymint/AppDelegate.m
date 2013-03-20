//
//  AppDelegate.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "AppDelegate.h"
#import "UpdateManager.h"

#import "Link.h"

#import "AFNetworking/AFHTTPClient.h"


@implementation AppDelegate

@synthesize window;
@synthesize ownViewController;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSString *seedStorePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"BrandymintSeed.sqlite"];

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Brandymint.sqlite"];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Brandymint.sqlite"];

    NSURL *baseURL = [NSURL URLWithString:@"http://brandymint.ru/api/v1"];
    
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Card class] pathPattern:@"cards" method:RKRequestMethodGET]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Link class] pathPattern:@"links" method:RKRequestMethodGET]];
    [objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[Bloc class] pathPattern:@"blocs" method:RKRequestMethodGET]];

    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];

    // Network Reachability Alert
    // Replace with reachability pod
//    [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == kSCNetworkReachabilityFlagsReachable) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
//                                                            message:@"You must be connected to the internet to use this app."
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
    
    // Initialize managed object store
    objectManager.managedObjectStore = managedObjectStore;
    
    RKEntityMapping *cardMapping = [RKEntityMapping mappingForEntityForName:@"Card" inManagedObjectStore:managedObjectStore];
    cardMapping.identificationAttributes = @[ @"key" ];
    [cardMapping addAttributeMappingsFromArray:@[@"title",@"desc",@"key",@"link",@"position",@"subtitle",@"updated_at",@"image_url",@"url"]];
    
    RKEntityMapping *blocMapping = [RKEntityMapping mappingForEntityForName:@"Bloc" inManagedObjectStore:managedObjectStore];
    blocMapping.identificationAttributes = @[ @"key" ];
    [blocMapping addAttributeMappingsFromArray:@[@"title",@"content",@"key",@"position",@"updated_at",@"icon_url",@"url"]];
   
    RKEntityMapping *linkMapping = [RKEntityMapping mappingForEntityForName:@"Link" inManagedObjectStore:managedObjectStore];
    linkMapping.identificationAttributes = @[ @"key" ];
    [linkMapping addAttributeMappingsFromArray:@[@"title",@"url",@"key",@"position",@"updated_at",]];
    
    //     [RKObjectMapping addDefaultDateFormatterForString:@"E MMM d HH:mm:ss Z y" inTimeZone:nil];
    
    RKResponseDescriptor *cardResponseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:cardMapping
                                                pathPattern:@"cards"
                                                keyPath:nil
                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:cardResponseDescriptor];
    
    RKResponseDescriptor *linkResponseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:linkMapping
                                                pathPattern:@"links"
                                                keyPath:nil
                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:linkResponseDescriptor];
    
    RKResponseDescriptor *blocResponseDescriptor = [RKResponseDescriptor
                                                    responseDescriptorWithMapping:blocMapping
                                                    pathPattern:@"blocs"
                                                    keyPath:nil
                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:blocResponseDescriptor];
    
    [managedObjectStore createPersistentStoreCoordinator];
        
    //      so that the object seeder can find the files when run in the simulator.
    
#ifdef GENERATE_SEED_DB
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    
    NSError *error;
    RKManagedObjectImporter *importer = [[RKManagedObjectImporter alloc] initWithManagedObjectModel:managedObjectModel storePath:seedStorePath];
    
    [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"/cards" ofType:@"json"]
                              withMapping:cardMapping
                                  keyPath:nil
                                    error:&error];

    BOOL success = [importer finishImporting:&error];
    if (success) {
        [importer logSeedingInfo];
    } else {
        RKLogError(@"Failed to finish import and save seed database due to error: %@", error);
    }
    
    // Clear out the root view controller
    // [self.window setRootViewController:[UIViewController new]];
#else
    /**
     Complete Core Data stack initialization
     */
    [managedObjectStore createPersistentStoreCoordinator];
    
    
    NSError *error = nil;
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                                   configuration:nil URL:storeURL
//                                                         options:nil error:&error]) {
//    }
    
    //NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"Brandymint" ofType:@"sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
#endif
    
    
    // Init windows
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    ownViewController = [[OwnViewController alloc] initWithNibName:@"OwnViewController" bundle:[NSBundle mainBundle]];
    
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = ownViewController;
    [window makeKeyAndVisible];
    
    //[self showAllFontsInConsole];
    
    return YES;
}

-(void) showAllFontsInConsole
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
    NSArray *fontNames;
    NSUInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[UpdateManager updateManager] updateData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Brandymint" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

//// Returns the persistent store coordinator for the application.
//// If the coordinator doesn't already exist, it is created and the application's store added to it.
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
//{
//    if (_persistentStoreCoordinator != nil) {
//        return _persistentStoreCoordinator;
//    }
//    
//   
//    
////    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
////        NSURL *preloadURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Brandymint" ofType:@"sqlite"]];
////        NSError* err = nil;
////        
////        if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeURL error:&err]) {
////            NSLog(@"Oops, could copy preloaded data");
////        }
////    }
//    
//    NSError *error = nil;
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                                   configuration:nil URL:storeURL
//                                                         options:nil error:&error]) {
//        /*
//         Replace this implementation with code to handle the error appropriately.
//         
//         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//         
//         Typical reasons for an error here include:
//         * The persistent store is not accessible;
//         * The schema for the persistent store is incompatible with current managed object model.
//         Check the error message to determine what the actual problem was.
//         */
//         
//         /*
//         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//         
//         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
//          
//          @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
//        
//          */
//        
//        /*
//         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//                * Simply deleting the existing store:
//         */
//        NSLog(@"Core Data Unresolved error %@, %@", error, [error userInfo]);
//        
//        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
//
//        //abort();
//    }    
//    
//    return _persistentStoreCoordinator;
//}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
