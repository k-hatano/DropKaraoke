//
//  ViewController.h
//  DropKaraoke
//
//  Created by HatanoKenta on 2017/07/04.
//  Copyright © 2017年 jp.nita. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (nonatomic, weak) IBOutlet NSProgressIndicator *indicator;

- (IBAction)startConverting:(id)sender;

@end

