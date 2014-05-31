//
//  WDEViewController.m
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import "WDEViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface WDEViewController ()

@property (nonatomic) BOOL isPlaying;

@end

@implementation WDEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.isPlaying = false;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nerdButtonTapped:(id)sender {
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Neeerd"
                                                           ofType:@"wav"];
    [self playSoundWithPath:soundPath];
    
}

- (void)animateButtonWithDuration:(float)seconds {
    
    UIColor *currentButtonColor = [self.nerdButton.backgroundColor copy];
    self.nerdButton.backgroundColor = [UIColor blackColor];
    self.nerdButton.alpha = 0.5;
    
    [UIView animateWithDuration:seconds
                     animations:^{
                         
                         self.nerdButton.backgroundColor = currentButtonColor;
                         self.nerdButton.alpha = 1.0;
                         
                     }];
    
}

- (void)playSoundWithPath:(NSString *)soundPath {
    
    if(self.isPlaying) {
        return;
    } else {
        self.isPlaying = true;
    }
    
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundId);
    AudioServicesAddSystemSoundCompletion(soundId,
                                          NULL,
                                          NULL,
                                          HandleSystemSoundCompleted,
                                          (__bridge_retained void *)self);
    
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:soundURL
                                                 options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    [self animateButtonWithDuration:audioDurationSeconds];
    
    AudioServicesPlaySystemSound(soundId);
    
}

void HandleSystemSoundCompleted(SystemSoundID soundId, void *myself) {

    NSLog(@"Handle system sound completed");
    
    AudioServicesRemoveSystemSoundCompletion(soundId);
    AudioServicesDisposeSystemSoundID(soundId);
    
    [(__bridge_transfer WDEViewController *)myself setIsPlaying:false];
    
}

@end
