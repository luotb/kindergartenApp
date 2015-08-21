//
//  PhotoVC.h
//  Tenement
//
//  Created by CxDtreeg on 15/3/2.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "BaseViewController.h"
#import "FuniAttachment.h"

typedef void(^CallBack)(NSArray*);

@interface PhotoVC : BaseViewController

@property(strong, nonatomic) NSMutableArray * imgMArray;
@property (strong, nonatomic) NSMutableArray * attachemnMArray;
@property (assign, nonatomic) NSInteger curentPage;

@property (strong, nonatomic) CallBack myBlock;

@end
