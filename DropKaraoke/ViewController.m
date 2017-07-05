//
//  ViewController.m
//  DropKaraoke
//
//  Created by HatanoKenta on 2017/07/04.
//  Copyright © 2017年 jp.nita. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startConverting:(id)sender {
    self.indicator.indeterminate = YES;
    [self.indicator startAnimation:self];
}


@end
