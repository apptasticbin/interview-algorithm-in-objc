//
//  BiNode.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 05/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiNode : NSObject

@property(nonatomic, strong) BiNode *node1;
@property(nonatomic, strong) BiNode *node2;
@property(nonatomic, assign) NSInteger data;

@end
