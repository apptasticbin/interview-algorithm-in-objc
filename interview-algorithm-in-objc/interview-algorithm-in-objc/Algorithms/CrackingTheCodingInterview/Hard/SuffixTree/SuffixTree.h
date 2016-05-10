//
//  SuffixTree.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 08/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SuffixTreeNode;

#pragma mark - SuffixTree

@interface SuffixTree : NSObject

@property(nonatomic, strong) SuffixTreeNode *rootNode;

- (instancetype)initWithString:(NSString *)string;
- (NSArray<NSNumber *> *)search:(NSString *)substring;

@end

#pragma mark - SuffixTreeNode

@interface SuffixTreeNode : NSObject

@property(nonatomic, strong) NSMutableDictionary<NSString *, SuffixTreeNode *> *children;
@property(nonatomic, strong) NSMutableArray<NSNumber *> *indexes;
@property(nonatomic, strong) NSString *value;

- (instancetype)init;
- (void)insertString:(NSString *)string index:(NSInteger)index;
- (NSArray<NSNumber *> *)search:(NSString *)substring;

@end
