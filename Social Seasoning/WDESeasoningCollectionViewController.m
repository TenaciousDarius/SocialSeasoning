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

@interface WDESeasoningCollectionViewController ()

@property (strong, nonatomic) NSArray *spiceRack;

@end

@implementation WDESeasoningCollectionViewController

NSString *const HeaderReuseIdentifier = @"SeasoningHeader";
NSString *const SpiceCellReuseIdentifier = @"SpiceCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.spiceRack = [NSArray arrayWithObjects:[[WDESpice alloc] initSpiceWithName:@"Neeerd!!"
                                                                          audioURL:@"Neeerd"],
                      nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    [currentCell.spiceTriggerButton setTitle:currentSpice.spiceName
                                    forState:UIControlStateNormal];
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

@end
