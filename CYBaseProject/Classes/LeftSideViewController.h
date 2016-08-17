//
//  LeftSideViewController.h
//  QQLeftSideSlipDemo
//
//  Created by Peter Lee on 16/8/16.
//  Copyright © 2016年 CY.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftSideViewOption : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *className;

@end

typedef void(^LeftSideOptionBlock)(LeftSideViewOption *option);

@interface LeftSideViewController : UIViewController

@property (nonatomic, copy) LeftSideOptionBlock leftSideOptionBlock;

@end
