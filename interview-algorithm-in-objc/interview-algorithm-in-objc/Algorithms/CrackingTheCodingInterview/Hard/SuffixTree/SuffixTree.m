//
//  SuffixTree.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 08/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "SuffixTree.h"

#pragma mark - SuffixTree

@implementation SuffixTree

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        _rootNode = [self createTreeFromString:string];
    }
    return self;
}

- (NSArray<NSNumber *> *)search:(NSString *)substring {
    return [self.rootNode search:substring];
}

#pragma mark - Private

- (SuffixTreeNode *)createTreeFromString:(NSString *)string {
    // root node doesn't have data
    SuffixTreeNode *rootNode = [SuffixTreeNode new];
    for (NSInteger i=0; i<string.length; i++) {
        NSString *suffix = [string substringFromIndex:i];
        [rootNode insertString:suffix index:i];
    }
    return rootNode;
}

@end

#pragma mark - SuffixTreeNode

@implementation SuffixTreeNode

- (instancetype)init {
    self = [super init];
    if (self) {
        _value = nil;
        _children = [NSMutableDictionary dictionary];
        _indexes = [NSMutableArray array];
    }
    return self;
}

- (void)insertString:(NSString *)string index:(NSInteger)index {
    // position indexes for each substring starts with this character
    [self.indexes addObject:@(index)];
    if (!string || !string.length) {
        return;
    }
    // the value if ONLY available for children nodes, not for root node
    self.value = [string substringWithRange:NSMakeRange(0, 1)];
    SuffixTreeNode *child = nil;
    if (self.children[self.value]) {
        child = self.children[self.value];
    } else {
        child = [SuffixTreeNode new];
        self.children[self.value] = child;
    }
    NSString *nextSubstring = [string substringFromIndex:1];
    [child insertString:nextSubstring index:index];
}

- (NSArray<NSNumber *> *)search:(NSString *)substring {
    if (!substring || !substring.length) {
        return self.indexes;
    }
    NSString *character = [substring substringWithRange:NSMakeRange(0, 1)];
    if (self.children[character]) {
        NSString *nextSubstring = [substring substringFromIndex:1];
        return [self.children[character] search:nextSubstring];
    }
    return nil;
}

@end
