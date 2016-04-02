//
//  Animal.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "Animal.h"

@implementation Animal

+ (Animal *)newCat {
    return [[Animal alloc] initWithType:Cat];
}

+ (Animal *)newDog {
    return [[Animal alloc] initWithType:Dog];
}

#pragma mark - Private

- (instancetype)initWithType:(AnimalType)type {
    self = [super init];
    if (self) {
        _type = type;
        _order = -1;
    }
    return self;
}

@end
