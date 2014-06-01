//
//  WDESpice.h
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDESpice : NSObject

@property (strong, nonatomic) NSString *spiceName;
@property (strong, nonatomic) NSURL *audioURL;

- (WDESpice *)initSpiceWithName:(NSString *)spiceName audioName:(NSString *)audioName audioType:(NSString *)audioType;

@end
