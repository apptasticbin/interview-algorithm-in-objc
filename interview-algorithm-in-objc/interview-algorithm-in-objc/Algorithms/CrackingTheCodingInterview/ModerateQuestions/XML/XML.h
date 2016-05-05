//
//  XML.h
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 05/05/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Element : NSObject

@property(nonatomic, strong) NSArray *attributes;
@property(nonatomic, strong) id value;

@end

@interface Attribute : NSObject

@end
