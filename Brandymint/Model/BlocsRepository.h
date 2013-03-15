//
//  BlocsRepository.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bloc.h>

@interface BlocsRepository : NSObject
{
    NSMutableArray *blocsBuffer;
}

@property (retain, readonly) NSMutableArray *blocsBuffer;

+(BlocsRepository *) sharedRepository;

-(NSManagedObjectContext*) managerContext;

-(Card*) findBlocByTitle: (NSString *)title;
-(void) deleteBloc:(Bloc *)bloc;
-(BOOL)saveData;
-(NSArray*) getAllBlocs;

@end
