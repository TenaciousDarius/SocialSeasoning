//
//  WDESpice.m
//  Social Seasoning
//
//  Created by Darius Elphick on 31/05/2014.
//  Copyright (c) 2014 Darius Elphick. All rights reserved.
//

#import "WDESpice.h"

@implementation WDESpice

- (WDESpice *)initSpiceWithName:(NSString *)spiceName audioName:(NSString *)audioName audioType:(NSString *)audioType {
    
    self = [super init];
    if (self) {
        
        self.spiceName = spiceName;
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:audioName
                                                              ofType:audioType];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        self.audioURL = soundURL;
        
    }
    return self;
    
}

@end
