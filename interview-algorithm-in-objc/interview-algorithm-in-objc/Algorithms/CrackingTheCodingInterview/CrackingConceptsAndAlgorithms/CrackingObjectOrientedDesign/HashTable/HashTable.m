//
//  HashTable.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 14/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "HashTable.h"
#import "HashTableCell.h"

@implementation HashTable

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
    }
    return self;
}

- (void)put:(id)value forKey:(id)key {
    /**
     - check if item at key's hash code is nil
     - if nil, create new linked cell list
     - if not, check if key exists in conflict list
     - if yes, remove old key value; if no, just continue
     - insert new key value
     */
}

- (id)getValueOfKey:(id)key {
    /**
     - check if item at key's hash code exists
     - if no, return nil
     - if exists, return collision list
     - traverse collision list to find exist key value
     - if not exists, return nil
     */
    return nil;
}

#pragma mark - Private

- (NSUInteger)hashCodeOfKey:(id)key {
    // Super stupid hash method, TEST ONLY
    if ([key isKindOfClass:[NSString class]]) {
        return [((NSString *)key) length];
    }
    return [key hash];
}

@end
