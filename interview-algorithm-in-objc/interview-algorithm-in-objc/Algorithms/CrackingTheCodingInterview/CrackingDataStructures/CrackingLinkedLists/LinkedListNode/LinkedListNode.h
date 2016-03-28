//
//  LinkedListNode.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 28/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkedListNode : NSObject

@property (nonatomic, strong) LinkedListNode *next;
@property (nonatomic, assign) NSInteger data;

+ (LinkedListNode *)nodeWithData:(NSInteger)data;
+ (LinkedListNode *)linkedListWithArray:(NSArray *)array;
+ (LinkedListNode *)deleteNodeInList:(LinkedListNode *)headNode withData:(NSInteger)data;

- (instancetype)initWithData:(NSInteger)data;
- (void)appendNodeToEnd:(NSInteger)data;
- (NSArray *)dataArrayFromList;
- (LinkedListNode *)nodeAtIndex:(NSInteger)index;
- (NSInteger)count;

@end
