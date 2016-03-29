//
//  Queue.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Queue.h"
#import "LinkedListNode.h"

@implementation Queue

- (void)enqueue:(NSInteger)data {
    LinkedListNode *newNode = [LinkedListNode nodeWithData:data];;
    if (!self.first) {
        self.first = self.last = newNode;
    } else {
        self.last.next = newNode;
        self.last = self.last.next;
    }
}

- (NSInteger)dequeue {
    if (!self.first) {
        @throw [NSException exceptionWithName:@"EmptyQueueException" reason:@"Queue is empty" userInfo:nil];
    }
    LinkedListNode *node = self.first;
    // release last node when dequeuing last one in queue.
    if (self.first == self.last) {
        self.last = self.last.next;
    }
    self.first = self.first.next;
    return node.data;
}

@end
