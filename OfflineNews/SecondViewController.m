//
//  SecondViewController.m
//  OfflineNews
//
//  Created by Evgeny Yagrushkin on 11-02-28.
//  Copyright 2011 JekSoft. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"


@implementation SecondViewController

@synthesize web;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // register for the notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWebView:) name:RefreshWebViewNotificationForTheSecondViewController object:nil];

    
    // load file with news by default
    // name of the file for the content
    NSString *name = [NSString stringWithFormat:@"news"];
    
    // get path for the user's data
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *fullName = [documentsDirectory stringByAppendingPathComponent:name];    

    [self loadData:fullName];
    
}

#pragma mark -
#pragma mark Notifications

- (void)refreshWebView:(NSNotification *)note
{
	NSString *fullName = [note object];
    [self loadData:fullName];
}

#pragma mark - 
#pragma mark File operations
- (void)loadData:(NSString *)name 
{
    NSString *content = [NSString stringWithContentsOfFile:name encoding:NSStringEncodingConversionAllowLossy error:nil];

    @try {
		[self.web loadHTMLString:content baseURL:nil];
	}
	@catch (NSException * e) {
	}
	@finally {
	}
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end
