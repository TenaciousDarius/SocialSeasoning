//
//  WDEViewController.m
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import "WDEViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface WDEViewController ()

@end

@implementation WDEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (void)playSoundWithPath:(NSString *)soundPath {
    
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundId);
    AudioServicesPlaySystemSound(soundId);
    
}

void HandleSystemSoundCompleted(SystemSoundID soundId) {

    AudioServicesDisposeSystemSoundID(soundId);
    
}

@end
