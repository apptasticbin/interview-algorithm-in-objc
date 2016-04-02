//
//  Animal.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 01/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AnimalType) {
    Cat = 0,
    Dog
};

@interface Animal : NSObject

@property(nonatomic, assign) AnimalType type;
@property(nonatomic, assign) NSInteger order;

+ (Animal *)newCat;
+ (Animal *)newDog;

@end
