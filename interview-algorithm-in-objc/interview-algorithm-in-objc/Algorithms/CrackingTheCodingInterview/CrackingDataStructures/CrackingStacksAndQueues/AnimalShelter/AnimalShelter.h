//
//  AnimalShelter.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Queue;
@class Animal;

@interface AnimalShelter : NSObject

@property(nonatomic, strong) Queue *catShelter;
@property(nonatomic, strong) Queue *dogShelter;
@property(nonatomic, assign) NSInteger currentOrder;

- (void)enqueue:(Animal *)animal;
- (Animal *)dequeueAny;
- (Animal *)dequeueCat;
- (Animal *)dequeueDog;

@end
