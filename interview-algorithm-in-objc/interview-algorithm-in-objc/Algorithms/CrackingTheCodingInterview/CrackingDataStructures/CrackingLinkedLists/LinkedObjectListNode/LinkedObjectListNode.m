//
//  LinkedObjectListNode.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "LinkedObjectListNode.h"

@implementation LinkedObjectListNode

+ (LinkedObjectListNode *)nodeWithData:(id)data {
    return [[LinkedObjectListNode alloc] initWithData:data];
}

- (instancetype)initWithData:(id)data {
    self = [super init];
    if (self) {
        _data = data;
        _next = nil;
    }
    return self;
}

- (void)appendNodeToEnd:(id)data {
    LinkedObjectListNode *node = [LinkedObjectListNode nodeWithData:data];
    LinkedObjectListNode *endNode = self;
    while (endNode.next) {
        endNode = endNode.next;
    }
    endNode.next = node;
}

+ (LinkedObjectListNode *)deleteNodeInList:(LinkedObjectListNode *)headNode withData:(id)data {
    LinkedObjectListNode *currentNode = headNode;
    // if delete first node, just move head pointer
    if (currentNode.data == data) {
        return headNode.next;
    }
    // traverse through list one by one
    while (currentNode.next) {
        if (currentNode.next.data == data) {
            currentNode.next = currentNode.next.next;
            return headNode;
        }
        currentNode = currentNode.next;
    }
    return headNode;
}

+ (LinkedObjectListNode *)linkedListWithArray:(NSArray *)array {
    if (!array || !array.count) {
        return nil;
    }
    LinkedObjectListNode *headNode = nil;
    for (NSInteger idx=0; idx<array.count; idx++) {
        if (!headNode) {
            headNode = [LinkedObjectListNode nodeWithData:array[idx]];
            continue;
        }
        [headNode appendNodeToEnd:array[idx]];
    }
    return headNode;
}

- (NSArray *)dataArrayFromList {
    NSMutableArray *array = [NSMutableArray array];
    LinkedObjectListNode *head = self;
    while (head) {
        [array addObject:head.data];
        head = head.next;
    }
    return array;
}

- (LinkedObjectListNode *)nodeAtIndex:(NSInteger)index {
    LinkedObjectListNode *node = self;
    for (NSInteger idx=0; idx<index; idx++) {
        if (!node.next) {
            return nil;
        }
        node = node.next;
    }
    return node;
}

- (NSInteger)count {
    NSInteger counter = 0;
    LinkedObjectListNode *runner = self;
    while (runner) {
        counter++;
        runner = runner.next;
    }
    return counter;
}

#pragma mark - NSObject

- (NSString *)description {
    NSArray *array = [self dataArrayFromList];
    return [array componentsJoinedByString:@" -> "];
}


@end
