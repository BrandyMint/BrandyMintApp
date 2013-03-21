//
//  ImagesRepository.h
//  Brandymint
//
//  Created by DenisDbv on 21.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "BaseRepository.h"

@interface ImagesRepository : BaseRepository

CWL_DECLARE_SINGLETON_FOR_CLASS(ImagesRepository)

-(void) printCountImagesFromDB;

@end
