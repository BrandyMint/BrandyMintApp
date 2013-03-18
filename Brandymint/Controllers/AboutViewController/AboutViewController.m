//
//  AboutViewController.m
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "AboutViewController.h"

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
        
        [self fillView:bloc index:loop];
    }
}

-(void) fillView:(Bloc*)bloc index:(NSInteger)index
{
    UIView *block1 = (UIView*)[self.view viewWithTag:index];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView = (UIImageView*)[block1 viewWithTag:IMAGETAG];
    UILabel *title = (UILabel*)[block1 viewWithTag:TITLETAG];
    UILabel *content = (UILabel*)[block1 viewWithTag:CONTENTTAG];
    
    imageView.image = bloc.icon.data;
    title.text = bloc.title;
    content.text = bloc.content;
}


@end
