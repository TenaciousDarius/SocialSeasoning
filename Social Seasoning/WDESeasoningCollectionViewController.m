//
//  WDESeasoningCollectionViewController.m
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import "WDESeasoningCollectionViewController.h"
#import "WDESocialSpiceViewCell.h"
#import "WDESpice.h"
#import <AudioToolbox/AudioToolbox.h>

@interface WDESeasoningCollectionViewController ()

@property (strong, nonatomic) NSArray *spiceRack;
@property (strong, nonatomic) NSIndexPath *currentSpiceIndex;
@property (nonatomic, assign) SystemSoundID currentSoundId;

@end

@implementation WDESeasoningCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.spiceRack = [NSArray arrayWithObjects: [[WDESpice alloc] initSpiceWithName:@"Neeerd!!"
                                                                          audioName:@"nerd"
                                                                          audioType:@"wav"],
                      nil];
    self.currentSoundId = -1;
    self.currentSpiceIndex = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Collection View Delegate and Data Source methods

NSString *const HeaderReuseIdentifier = @"SeasoningHeader";
NSString *const SpiceCellReuseIdentifier = @"SpiceCell";

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.spiceRack.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WDESpice *currentSpice = [self.spiceRack objectAtIndex:[indexPath row]];
    
    WDESocialSpiceViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:SpiceCellReuseIdentifier
                                                                                    forIndexPath:indexPath];
    
    currentCell.spiceNameLabel.text = currentSpice.spiceName;
    return currentCell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header = nil;
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:HeaderReuseIdentifier
                                                           forIndexPath:indexPath];
        
    }
    return header;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath == self.currentSpiceIndex) {
        [self stopCurrentSound];
    } else if {
    
        WDESpice *selectedSpice = [self.spiceRack objectAtIndex:indexPath.row];
        self.currentSpiceIndex = indexPath;
    
        NSLog(@"Selected spice: %@", selectedSpice.spiceName);
    
        [self playSoundWithURL:selectedSpice.audioURL];
    
    }
    
}

#pragma mark -
#pragma mark Core Audio Methods

- (void)playSoundWithURL:(NSURL *)soundURL {
    
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundId);
    self.currentSoundId = soundId;
    AudioServicesAddSystemSoundCompletion(soundId,
                                          NULL,
                                          NULL,
                                          HandleSystemSoundCompleted,
                                          (__bridge_retained void *)self);
    
    AudioServicesPlaySystemSound(soundId);
    
}

void HandleSystemSoundCompleted(SystemSoundID soundId, void *myself) {
    
    NSLog(@"Handle system sound completed");
    
    [(__bridge_transfer WDESeasoningCollectionViewController *)myself stopSoundWithID:soundId];
    
}

- (void) stopCurrentSound {
    [self stopSoundWithID:self.currentSoundId];
}

- (void) stopSoundWithID:(SystemSoundID)systemSoundId {
    
    AudioServicesRemoveSystemSoundCompletion(systemSoundId);
    AudioServicesDisposeSystemSoundID(systemSoundId);
    
    if (systemSoundId == self.currentSoundId) {
        self.currentSoundId = -1;
        self.currentSpiceIndex = nil;
    }
    
}

@end
