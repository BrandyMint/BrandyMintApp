//
//  OwnViewController.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollCards;
@property (nonatomic, strong) IBOutlet UIImageView *logo;

@property (nonatomic, strong) IBOutlet UIButton *cloudBtn;
-(IBAction) onCloudClick:(id)sender;

@end
