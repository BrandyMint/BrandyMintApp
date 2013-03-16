//
//  BlocsRepository.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bloc.h>
#import "BaseRepository.h"
#import "CWLSynthesizeSingleton.h"

@interface BlocsRepository : BaseRepository
CWL_DECLARE_SINGLETON_FOR_CLASS(BlocsRepository)
@end
