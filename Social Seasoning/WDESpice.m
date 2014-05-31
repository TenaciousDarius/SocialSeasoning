//
//  WDESpice.m
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import "WDESpice.h"

@implementation WDESpice

- (WDESpice *)initSpiceWithName:(NSString *)spiceName audioURL:(NSString *)audioURL {
    
    self = [super init];
    if (self) {
        
        self.spiceName = spiceName;
        NSURL *soundURL = [NSURL fileURLWithPath:audioURL];
        self.audioURL = soundURL;
        
    }
    return self;
    
}

@end
