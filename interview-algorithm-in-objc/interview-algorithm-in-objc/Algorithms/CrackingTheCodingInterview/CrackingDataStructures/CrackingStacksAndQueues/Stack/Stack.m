//
//  Stack.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Stack.h"
#import "LinkedListNode.h"

@implementation Stack

- (void)push:(NSInteger)data {
    LinkedListNode *newTop = [LinkedListNode nodeWithData:data];
    newTop.next = self.top;
    self.top = newTop;
}

- (NSInteger)pop {
    if (!self.top) {
        @throw [NSException exceptionWithName:@"EmptyStackException" reason:@"Stack is empty" userInfo:nil];
    }
    NSInteger topData = self.top.data;
    self.top = self.top.next;
    return topData;
}

- (NSInteger)peek {
    if (!self.top) {
        @throw [NSException exceptionWithName:@"EmptyStackException" reason:@"Stack is empty" userInfo:nil];
    }
    return self.top.data;
}

@end
