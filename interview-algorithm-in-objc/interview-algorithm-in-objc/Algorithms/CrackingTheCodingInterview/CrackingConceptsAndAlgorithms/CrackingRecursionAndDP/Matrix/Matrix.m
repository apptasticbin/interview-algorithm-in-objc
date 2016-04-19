//
//  Matrix.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 18/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Matrix.h"

@interface Matrix ()

@property(nonatomic, strong) NSMutableArray<NSMutableArray *> *items;
@property(nonatomic, assign, readwrite) NSUInteger row;
@property(nonatomic, assign, readwrite) NSUInteger column;

@end

@implementation Matrix

+ (instancetype)matrixWithRow:(NSUInteger)row column:(NSUInteger)column {
    return [[self alloc] initWithRow:row column:column];
}

- (instancetype)initWithRow:(NSUInteger)row column:(NSUInteger)column {
    self = [super init];
    if (self) {
        _row = row;
        _column = column;
        _items = [self emptyMatrixItems];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _row = [aDecoder decodeIntegerForKey:@"row"];
        _column = [aDecoder decodeIntegerForKey:@"column"];
        _items = [aDecoder decodeObjectForKey:@"items"];
    }
    return self;
}

- (NSInteger)itemAtRow:(NSUInteger)row column:(NSUInteger)column {
    [self rangeGuard:row column:column];
    NSMutableArray *rowArray = self.items[row];
    return [rowArray[column] integerValue];
}

- (void)setItemAtRow:(NSUInteger)row column:(NSUInteger)column data:(NSInteger)data {
    [self rangeGuard:row column:column];
    NSMutableArray *rowArray = self.items[row];
    rowArray[column] = @(data);
}

- (Matrix *)clone {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.row forKey:@"row"];
    [aCoder encodeInteger:self.column forKey:@"column"];
    [aCoder encodeObject:self.items forKey:@"items"];
}

#pragma mark - Private

- (void)rangeGuard:(NSUInteger)row column:(NSUInteger)column {
    if (!self.items.count ||
        self.items.count <= row ||
        self.items[0].count <= column) {
        @throw [NSException exceptionWithName:@"MatrixOutOfRange"
                                       reason:@"Out of matrix range"
                                     userInfo:nil];
    }
}

- (NSMutableArray *)emptyMatrixItems {
    NSMutableArray *items = [NSMutableArray array];
    for (NSUInteger row=0; row<self.row; row++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (NSUInteger column=0; column<self.column; column++) {
            [rowArray addObject:@(0)];
        }
        [items addObject:rowArray];
    }
    return items;
}

#pragma mark - NSObject

- (NSString *)description {
    NSMutableArray *rowStringArray = [NSMutableArray array];
    for (NSUInteger row=0; row<self.row; row++) {
        NSArray *rowArray = self.items[row];
        NSString *rowString = [rowArray componentsJoinedByString:@" "];
        [rowStringArray addObject:rowString];
    }
    return [NSString stringWithFormat:@"\n%@", [rowStringArray componentsJoinedByString:@"\n"]];
}

- (BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    Matrix *anotherObject = object;
    return [self.items isEqualToArray:anotherObject.items];
}

@end
