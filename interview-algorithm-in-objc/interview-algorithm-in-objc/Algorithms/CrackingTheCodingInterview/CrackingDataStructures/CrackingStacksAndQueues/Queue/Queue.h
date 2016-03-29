//
//  Queue.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LinkedListNode;

@interface Queue : NSObject

@property (nonatomic, strong) LinkedListNode *first;
@property (nonatomic, strong) LinkedListNode *last;

- (void)enqueue:(NSInteger)data;
- (NSInteger)dequeue;

@end
