//
//  FilePrinter.hpp
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 26/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#ifndef MyCppClass_hpp
#define MyCppClass_hpp

#include <stdio.h>
#include <string>
#include <fstream>

using namespace std;

class MyCppClass {
    // read file
    string _fileName;
    string *_lastLines;
    
public:
    // node traversal
    MyCppClass *ptr1;
    MyCppClass *ptr2;
    
public:
    // constructor and destructor
    MyCppClass();
    MyCppClass(string fileName);
    virtual ~MyCppClass();
    // methods
    void printLastLinesOfFile(int lineNumber);
    int **my2DAlloc(int row, int col);
    int **my2DAllocLinear(int row, int col);
    
private:
    void cleanLastLines();
};

#endif /* FilePrinter_hpp */
