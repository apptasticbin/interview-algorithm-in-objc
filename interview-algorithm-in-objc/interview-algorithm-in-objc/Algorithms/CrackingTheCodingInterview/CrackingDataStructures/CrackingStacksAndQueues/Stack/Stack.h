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

- (void)push:(NSInteger)data;
- (NSInteger)pop;
- (NSInteger)peek;

@end
