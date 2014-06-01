//
//  WDESpice.m
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import "WDESpice.h"
#import <AVFoundation/AVFoundation.h>

@implementation WDESpice

- (WDESpice *)initSpiceWithName:(NSString *)spiceName audioName:(NSString *)audioName audioType:(NSString *)audioType {
    
    self = [super init];
    if (self) {
        
        self.spiceName = spiceName;
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:audioName
                                                              ofType:audioType];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        self.audioURL = soundURL;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                 (unsigned long)NULL), ^(void) {
            [self lookupAudioDurationSeconds];
        });
        
    }
    return self;
    
}

- (void)lookupAudioDurationSeconds {
    
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:self.audioURL
                                                 options:nil];
    CMTime audioDuration = audioAsset.duration;
    self.audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    
    NSLog(@"Duration seconds: %f", self.audioDurationSeconds);
    
}

@end
