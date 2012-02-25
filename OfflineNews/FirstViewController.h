//
//  FirstViewController.h
//  OfflineNews
//
//  Created by Evgeny Yagrushkin on 11-02-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const RefreshWebViewNotificationForTheSecondViewController;

@interface FirstViewController : UIViewController {

    // storage for the downloaded content
    NSMutableData *responseData;
    NSURLConnection *connection;
    int ContentSize;
    
    // downloading process flag
    BOOL isDownloading;

}

@property (nonatomic, retain) IBOutlet UIProgressView *Progress;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *Activity;
@property (nonatomic, retain) IBOutlet UITextField *NewsUrl;

// button to start download
- (IBAction) buttonDownload: (id) sender;

- (void) StartDownLoad;
@end
