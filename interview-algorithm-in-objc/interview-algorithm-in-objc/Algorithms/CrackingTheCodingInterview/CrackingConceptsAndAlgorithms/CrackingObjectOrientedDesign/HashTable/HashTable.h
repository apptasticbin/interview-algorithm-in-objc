//
//  HashTable.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 14/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HashTableCell<K, V>;
@class LinkedObjectListNode<ObjectType>;

@interface HashTable<Key, Value> : NSObject

@property(nonatomic, strong)NSMutableArray<LinkedObjectListNode<__kindof HashTableCell<Key, Value> *> *> *items;
- (void)put:(Value)value forKey:(Key)key;
- (Value)getValueOfKey:(Key)key;

@end
