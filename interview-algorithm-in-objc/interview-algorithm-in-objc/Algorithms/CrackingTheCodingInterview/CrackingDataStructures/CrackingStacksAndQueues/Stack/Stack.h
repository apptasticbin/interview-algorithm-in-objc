//
//  Stack.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 29/03/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LinkedListNode;

@interface Stack : NSObject

@property (nonatomic, strong) LinkedListNode *top;
@property (nonatomic, assign) NSInteger capacity;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger tag;

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (void)push:(NSInteger)data;
- (NSInteger)pop;
- (NSInteger)popFromBottom;
- (NSInteger)peek;
- (BOOL)isEmpty;
- (BOOL)isFull;

@end
