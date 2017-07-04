//
//  Document.h
//  DropKaraoke
//
//  Created by HatanoKenta on 2017/07/04.
//  Copyright © 2017年 jp.nita. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument

@property (nonatomic, weak) IBOutlet NSTextView *fileNameTextView;

@end

