//
//  OnlyEmojiView.m
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/16.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "OnlyEmojiView.h"

@implementation OnlyEmojiView


- (IBAction)emojiBtnPressed:(UIButton *)sender {
    if (_pressedBlock) {
        _pressedBlock(sender);
    }
}

@end
