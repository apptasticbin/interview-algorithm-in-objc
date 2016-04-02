//
//  Queue.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Queue.h"
#import "LinkedObjectListNode.h"

@implementation Queue

- (void)enqueue:(id)data {
    LinkedObjectListNode *newNode = [LinkedObjectListNode nodeWithData:data];;
    if (!self.first) {
        self.first = self.last = newNode;
    } else {
        self.last.next = newNode;
        self.last = self.last.next;
    }
    self.count++;
}

- (id)dequeue {
    if (!self.first) {
        return nil;
    }
    LinkedObjectListNode *node = self.first;
    // release last node when dequeuing last one in queue.
    if (self.first == self.last) {
        self.last = self.last.next;
    }
    self.first = self.first.next;
    self.count--;
    return node.data;
}

- (BOOL)isEmpty {
    return !self.count;
}

@end
