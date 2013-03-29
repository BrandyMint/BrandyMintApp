//
//  ThumbView.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 28.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbView : UIView

@property (strong, nonatomic) IBOutlet UIScrollView *thumbsScrollView;

-(void) fillContent;
-(void) setActivePage:(NSUInteger)pageIndex;

@end
