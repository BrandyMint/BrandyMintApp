//
//  CardsRepository.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CardsRepository.h"

@implementation CardsRepository

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(CardsRepository)

-(NSString *) entityName { return @"Card"; }

@end
