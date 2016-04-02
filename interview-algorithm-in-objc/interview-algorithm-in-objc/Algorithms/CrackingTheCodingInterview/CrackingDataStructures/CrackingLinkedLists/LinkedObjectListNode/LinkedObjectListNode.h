//
//  LinkedObjectListNode.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkedObjectListNode : NSObject

@property (nonatomic, strong) LinkedObjectListNode *next;
@property (nonatomic, strong) id data;

+ (LinkedObjectListNode *)nodeWithData:(id)data;
+ (LinkedObjectListNode *)linkedListWithArray:(NSArray *)array;
+ (LinkedObjectListNode *)deleteNodeInList:(LinkedObjectListNode *)headNode withData:(id)data;

- (instancetype)initWithData:(id)data;
- (void)appendNodeToEnd:(id)data;
- (NSArray *)dataArrayFromList;
- (LinkedObjectListNode *)nodeAtIndex:(NSInteger)index;
- (NSInteger)count;

@end
