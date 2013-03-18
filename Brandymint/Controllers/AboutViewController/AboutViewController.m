//
//  AboutViewController.m
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "AboutViewController.h"
#import "BlockView.h"
#import "LinksView.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // init
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void) viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor clearColor];
    
    NSUInteger blocsCount = [BlocsRepository sharedBlocsRepository].entitiesBuffer.count;
    
    for(NSInteger loop = 0; loop < blocsCount; loop++)
    {
        Bloc *bloc = [[BlocsRepository sharedBlocsRepository].entitiesBuffer objectAtIndex: (NSUInteger)loop ];
        
        BlockView * blockView = (BlockView*)[self.view viewWithTag: loop+1 ];
        if([blockView isKindOfClass:[BlockView class]])  {
            [blockView fillView:bloc];
        }
    }
}

@end
