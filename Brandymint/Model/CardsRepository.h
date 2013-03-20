//
//  CardsRepository.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "BaseRepository.h"
#import "CWLSynthesizeSingleton.h"

@interface CardsRepository : BaseRepository
CWL_DECLARE_SINGLETON_FOR_CLASS(CardsRepository)
@end
