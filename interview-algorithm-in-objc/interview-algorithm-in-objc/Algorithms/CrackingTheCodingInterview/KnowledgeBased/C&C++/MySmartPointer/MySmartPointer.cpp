//
//  MySmartPointer.cpp
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 27/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#include "MySmartPointer.hpp"
#include <cstdlib>

template<class T>
MySmartPointer<T>::MySmartPointer(T *ptr) {
    _ptr = ptr;
    _referenceCounter = (unsigned *)malloc(sizeof(unsigned));
    *_referenceCounter = 1;
}

template<class T>
MySmartPointer<T>::MySmartPointer(MySmartPointer<T> &smartPtr) {
    _ptr = smartPtr._ptr;
    _referenceCounter = smartPtr._referenceCounter;
    (*_referenceCounter)++;
}

template<class T>
MySmartPointer<T> & MySmartPointer<T>::operator=(MySmartPointer<T> &smartPtr) {
    if (this == &smartPtr) {
        return *this;
    }
    if (*_referenceCounter > 0) {
        remove();
    }
    _ptr = smartPtr._ptr;
    _referenceCounter = smartPtr._referenceCounter;
    (*_referenceCounter)++;
    return *this;
}

template<class T>
MySmartPointer<T>::~MySmartPointer() {
    remove();
}

template<class T>
T * MySmartPointer<T>::getPtr() {
    return _ptr;
}

template<class T>
void MySmartPointer<T>::remove() {
    (*_referenceCounter)--;
    if (*_referenceCounter == 0) {
        delete _ptr;
        free(_referenceCounter);
        _ptr = NULL;
        _referenceCounter = NULL;
    }
}