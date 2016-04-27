//
//  MySmartPointer.hpp
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#ifndef MySmartPointer_hpp
#define MySmartPointer_hpp

#include <stdio.h>

template<class T> class MySmartPointer {
    /* The smart pointer class needs pointers to both the object
     * itself and to the ref count. These must be pointers, rather 
     * than the actual object or ref count value, since the goal of 
     * a smart pointer is that the reference count is tracked across 
     * multiple smart pointers to one object. 
     */
protected:
    T *_ptr;
    unsigned *_referenceCounter;
    
public:
    // constructor
    MySmartPointer(T *ptr);
    // copy constructor
    MySmartPointer(MySmartPointer<T> &smartPtr);
    // copy assignment operator
    MySmartPointer<T> &operator=(MySmartPointer<T> &smartPtr);
    // destructor
    ~MySmartPointer();
    
    T *getPtr();
    
protected:
    void remove();
};

#endif /* MySmartPointer_hpp */
