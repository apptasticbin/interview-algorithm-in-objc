//
//  Queue.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LinkedObjectListNode;

@interface Queue : NSObject

@property(nonatomic, strong) LinkedObjectListNode *first;
@property(nonatomic, strong) LinkedObjectListNode *last;
@property(nonatomic, assign) NSInteger count;

- (void)enqueue:(id)data;
- (id)dequeue;
- (BOOL)isEmpty;

@end
