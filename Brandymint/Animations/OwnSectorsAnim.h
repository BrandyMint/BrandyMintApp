//
//  OwnSectorsAnim.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 12.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (OwnSectorsAnim)

-(void) showBrandymintLogo;
-(void) showDevelopersLogo;
-(void) showTopLine;

-(void) showBottomLine;
-(void) hideBottomLine:(void(^)(BOOL finished))finishBlock;

@end
