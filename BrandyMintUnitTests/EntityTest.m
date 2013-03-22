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
    STAssertTrue([_entity isKindOfClass:[Entity class]], @"Сущность типа Entity");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test_updateFromDict
{
    // мы ожидаем что метод updateFromDict класса UpdateManager
    // вызовет у входого параметра метод enumerateKeysAndObjectsUsingBlock
    id dict = [OCMockObject mockForClass:[NSDictionary class]];
 
    [[dict expect] enumerateKeysAndObjectsUsingBlock:[OCMArg any]];
    
    [_entity updateFromDict:dict];
    
    [dict verify];
}

@end

// Хороший пример мокинга
// http://stackoverflow.com/questions/5477219/objective-c-unit-testing-mocking-objects
