//
//  UpdateManager.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateManager : NSObject

+(UpdateManager *) updateManager;

-(void) updateData;

@end
