//
//  WebViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 25.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
{
    NSURL* _url;
}

@synthesize navBar;
@synthesize webView;

-(id)initWithURL:(NSString*)url
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _url = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction) onBackButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) onOpenInButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:_url];
}

@end
