//
//  BlockView.h
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockView : UIView

@property (nonatomic, assign) IBOutlet UIImageView *icon;
@property (nonatomic, assign) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) IBOutlet UILabel *contentLabel;

-(void) fillView:(Bloc*)bloc;

@end
