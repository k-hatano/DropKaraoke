//
//  Document.m
//  DropKaraoke
//
//  Created by HatanoKenta on 2017/07/04.
//  Copyright © 2017年 jp.nita. All rights reserved.
//

#import "Document.h"

#include "WavUtil.h"

@interface Document ()

@property (nonatomic, retain) NSString *filePath;

@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

+ (BOOL)autosavesInPlace {
    return YES;
}


- (void)makeWindowControllers {
    // Override to return the Storyboard file name of the document.
    [self addWindowController:[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"Document Window Controller"]];
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    NSString *path = [url path];
    
    self.filePath = path;
    
    return YES;
}

- (IBAction)removeVocal:(id)sender {
    StereoWAV inputWav;
    MonoWAV outputWav;
    unsigned int i;
    
    const char *importFileName;
    char *exportFileName;
    
    ViewController *viewController = self.windowControllers[0].contentViewController;
    [viewController startConverting:self];
    
    importFileName = [self.filePath cStringUsingEncoding:NSASCIIStringEncoding];
    
    if (strstr(importFileName, ".wav") == NULL && strstr(importFileName, ".WAV") == NULL) {
        printf("Error: import file seems not to be a wav file \n");
        return;
    }
    
    exportFileName = calloc(strlen(importFileName) + 4, sizeof(char));
    strcpy(exportFileName, importFileName);
    strcpy(&exportFileName[strlen(importFileName) - 4], "_vk.wav");
    
    printf("Importing wav file...\n");
    int result = importStereoWav(&inputWav, importFileName);
    
    if (result == ERROR_FILE_NOT_FOUND) {
        printf("Error: input file not found.\n");
    } else if (inputWav.channels != 2) {
        printf("Error: input file is not a stereo wav file.\n");
    } else {
        outputWav.sampleRate = inputWav.sampleRate;
        outputWav.bps = inputWav.bps;
        outputWav.length = inputWav.length;
        
        outputWav.data = calloc(outputWav.length, sizeof(double));
        
        printf("Generating wave data...\n");
        for (i = 0; i < outputWav.length; i++) {
            outputWav.data[i] = inputWav.dataLeft[i] - inputWav.dataRight[i];
        }
        
        printf("Exporting wav file...\n");
        exportMonoWav(&outputWav, exportFileName);
        
        printf("Complete!\n");
        
        free(outputWav.data);
    }
    
    NSString *fileName = [NSString stringWithCString:exportFileName encoding:NSASCIIStringEncoding];
    [[NSWorkspace sharedWorkspace] selectFile:fileName inFileViewerRootedAtPath:@"/"];
    
    free(inputWav.dataLeft);
    free(inputWav.dataRight);
    free(exportFileName);
    
    [self.windowControllers[0] close];
}


@end
