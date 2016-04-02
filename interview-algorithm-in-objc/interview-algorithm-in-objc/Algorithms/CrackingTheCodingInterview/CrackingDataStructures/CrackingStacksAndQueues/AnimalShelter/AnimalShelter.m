//
//  AnimalShelter.m
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import "AnimalShelter.h"
#import "Animal.h"
#import "LinkedObjectListNode.h"
#import "Queue.h"

@implementation AnimalShelter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _catShelter = [Queue new];
        _dogShelter = [Queue new];
        _currentOrder = 0;
    }
    return self;
}

- (void)enqueue:(Animal *)animal {
    if (animal.type == Cat) {
        [self.catShelter enqueue:animal];
    } else {
        [self.dogShelter enqueue:animal];
    }
    animal.order = self.currentOrder;
    self.currentOrder++;
}

- (Animal *)dequeueAny {
    if ([self.catShelter isEmpty] && [self.dogShelter isEmpty]) {
        return nil;
    } else if ([self.catShelter isEmpty]) {
        return [self dequeueDog];
    } else if ([self.dogShelter isEmpty]) {
        return [self dequeueCat];
    } else {
        Animal *firstCat = self.catShelter.first.data;
        Animal *firstDog = self.dogShelter.first.data;
        if (firstCat.order < firstDog.order) {
            return [self dequeueCat];
        } else {
            return [self dequeueDog];
        }
    }
}

- (Animal *)dequeueCat {
    return [self.catShelter dequeue];
}

- (Animal *)dequeueDog {
    return [self.dogShelter dequeue];
}

@end
