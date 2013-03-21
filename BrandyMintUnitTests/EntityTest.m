//
//  EntityTest.m
//  Brandymint
//
//  Created by Danil Pismenny on 21.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "EntityTest.h"

@implementation EntityTest

- (void)setUp
{
    [super setUp];
    
    _entity = [[Entity alloc] init];
    
    STAssertNotNil(_entity, @"Сущность существует");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testEntityClass
{
    STAssertTrue([_entity isKindOfClass:[Entity class]], @"Сущность типа Entity");
}

@end
