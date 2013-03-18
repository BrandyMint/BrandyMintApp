//
//  BlockView.h
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    IMAGETAG = 2,
    TITLETAG,
    CONTENTTAG
};

@interface BlockView : UIView

@property (nonatomic, assign) UIImageView *icon;
@property (nonatomic, assign) UILabel *title;
@property (nonatomic, assign) UILabel *content;

-(void) fillView:(Bloc*)bloc;

@end
