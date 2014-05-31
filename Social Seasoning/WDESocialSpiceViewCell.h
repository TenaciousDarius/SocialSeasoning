//
//  WDESocialSpiceViewCell.h
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDESocialSpiceViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIButton *spiceTriggerButton;

- (IBAction)spiceButtonPressed:(id)sender;

@end
