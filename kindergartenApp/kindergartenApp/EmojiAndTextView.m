//
//  EmojiAndTextView.m
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/17.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "EmojiAndTextView.h"

@implementation EmojiAndTextView

- (IBAction)emojiBtnPressed:(UIButton *)sender {
//    if (_pressedBlock) {
//        _pressedBlock(sender);
//    }
    [KGEmojiManage sharedManage].isChatEmoji = YES;
    sender.selected = !sender.selected;
    
    [KGEmojiManage sharedManage].isSwitchEmoji = YES;
    [_contentTextView resignFirstResponder];
    
    if (!_faceBoard) {
        _faceBoard = [[FaceBoard alloc] init];
        _faceBoard.inputTextView = _contentTextView;
    }
    
    if(sender.selected) {
        _contentTextView.inputView = _faceBoard;
    } else {
        _contentTextView.inputView = nil;
    }
    
    [_contentTextView becomeFirstResponder];
}

- (IBAction)postBtnPressed:(UIButton *)sender {
    
}

@end
