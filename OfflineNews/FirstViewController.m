//
//  FirstViewController.m
//  OfflineNews
//
//  Created by Evgeny Yagrushkin on 11-02-28.
//  Copyright 2011 JekSoft. All rights reserved.
//

#import "FirstViewController.h"

NSString * const RefreshWebViewNotificationForTheSecondViewController = @"RefreshWebView";


@implementation FirstViewController

@synthesize Activity, Progress, NewsUrl;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    // init controls
    Progress.alpha = 0;
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

#pragma mark -
#pragma mark DownLoad news

- (IBAction) buttonDownload: (id) sender
{
    [self.NewsUrl resignFirstResponder];

    if (isDownloading) {
        [connection cancel];
        [connection release];
    }
    [self StartDownLoad];
}

- (void) StartDownLoad
{
	NSString *requeststr = [self.NewsUrl text];

    NSLog(@"StartDownLoad url:%@", requeststr);
    
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requeststr]];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	isDownloading = YES;
}

#pragma mark -
#pragma mark Connection delegate



- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response {
    [Activity startAnimating];
	[responseData setLength:0];
    
    // from SDK
    //Some protocol implementations report the content length as part of the response, but not all protocols guarantee to deliver that amount of data. Clients should be prepared to deal with more or less data.
    ContentSize = [[[NSNumber numberWithLong: [response expectedContentLength] ] retain] intValue];
    if (ContentSize == NSURLResponseUnknownLength && [response isKindOfClass:[NSHTTPURLResponse self]]) {
		NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
		ContentSize = [[headers objectForKey:@"Content-Length"] intValue];
		NSLog(@"Incoming length: %i", ContentSize);
	}
    
    
    NSLog(@"%d", ContentSize);
    
    // show progress bar
    [self.Progress setAlpha:1.0];
	[self.Progress setProgress:0];
    
    if (ContentSize == NSURLResponseUnknownLength || ContentSize == 0) 
    {
        ContentSize = 15000;
    }
    
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
	[responseData appendData:data];
    
    NSNumber* curLength = [NSNumber numberWithLong:[responseData length] ];
	float tmp_progress = [curLength floatValue] / (float)ContentSize;
    if (tmp_progress > 1) 
    {
        tmp_progress = tmp_progress - (float)(int)tmp_progress;
    }
    // set current progress for the progress bar
	[self.Progress setProgress:tmp_progress];
    
    NSLog(@"didReceiveData %d of %d, %f", [curLength intValue], ContentSize, tmp_progress);
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
    [self.Progress setProgress:0.0];
    [Activity stopAnimating];
    [self.Progress setAlpha:0];
	[connection release];
	isDownloading = NO;
	NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    [Activity stopAnimating];
    [self.Progress setProgress:1.0];
    [self.Progress setAlpha:0];
	isDownloading = NO;
	[connection release];
    
    if ([responseData length] > 0) 
    {
        // name of the file for the content
        NSString *name = [NSString stringWithFormat:@"news"];
        
        // get path for the user's data
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullName = [documentsDirectory stringByAppendingPathComponent:name];    
        
        NSLog(@"connectionDidFinishLoading %@", fullName);
        
        if ([[NSFileManager defaultManager] createFileAtPath:fullName contents:responseData attributes:nil]) 
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:RefreshWebViewNotificationForTheSecondViewController object:fullName];
        }
    }
	[responseData release];
//	[responseString release];	
}

- (void)dealloc
{
    [super dealloc];
}

@end
