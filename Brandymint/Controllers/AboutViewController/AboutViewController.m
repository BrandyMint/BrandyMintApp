//
//  AboutViewController.m
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "AboutViewController.h"
#import "BlockView.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize blocs;

- (id)initAboutController:(NSArray*)blocArray
{
    self = [super initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        
        self.blocs = blocArray;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void) viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor clearColor];
    
    for(NSInteger loop = 0; loop < blocs.count; loop++)
    {
        Bloc *bloc = [blocs objectAtIndex:(NSUInteger)loop];
        
        BlockView * blockView = (BlockView*)[self.view viewWithTag:loop+1];
        [blockView fillView:bloc];
    }
}




@end
