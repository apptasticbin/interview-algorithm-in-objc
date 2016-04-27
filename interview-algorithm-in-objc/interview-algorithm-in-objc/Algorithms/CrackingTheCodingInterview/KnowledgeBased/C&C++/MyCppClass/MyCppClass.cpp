//
//  FilePrinter.cpp
//  interview-algorithm-in-objc
//
//  Created by Bin Yu on 26/04/16.
//  Copyright © 2016 Bin Yu. All rights reserved.
//

#include "MyCppClass.hpp"
#include <iostream>
#include <map>

#pragma mark - Copy Recursive

typedef map<MyCppClass*, MyCppClass*> NodeMap;

MyCppClass *copy_recersive(MyCppClass *node, NodeMap &nodeMap) {
    if (node == NULL) {
        return NULL;
    }
    NodeMap::iterator i = nodeMap.find(node);
    if (i != nodeMap.end()) {
        return i->second;
    }
    
    MyCppClass *newNode = new MyCppClass();
    nodeMap[node] = newNode;
    newNode->ptr1 = copy_recersive(node->ptr1, nodeMap);
    newNode->ptr2 = copy_recersive(node->ptr2, nodeMap);
    return newNode;
}

#pragma mark - MyCppClass

MyCppClass::MyCppClass(): MyCppClass(NULL) {
    
}

MyCppClass::MyCppClass(string fileName): _fileName(fileName), ptr1(NULL), ptr2(NULL) {
    
}

MyCppClass::~MyCppClass() {
    this->cleanLastLines();
}

/**
 - using circular array
 - be careful of starting point in circular array
 */
void MyCppClass::printLastLinesOfFile(int lineNumber) {
    // clean previous lines
    this->cleanLastLines();
    // open file input stream
    ifstream file(this->_fileName.c_str());
    // create new lines array
    this->_lastLines = new string[lineNumber];
    
    // now read lines one by one
    int counter = 0;
    while (file.good()) {
        getline(file, this->_lastLines[counter % lineNumber]);
        counter++;
    }
    
    int start = counter > lineNumber ? counter % lineNumber : 0;
    int count = min(lineNumber, counter);
    for (int i=0; i<count; i++) {
        cout << this->_lastLines[(start+i)%lineNumber] << endl;
    }
}

int ** MyCppClass::my2DAlloc(int row, int col) {
    int ** rows = (int **)malloc(sizeof(int *) * row);
    for (int i=0; i<row; i++) {
        rows[i] = (int *)malloc(sizeof(int) * col);
    }
    return rows;
}

/**
 - Is this way a little bit risky ? e.g. when access out-of-bound index of each row
 */
int ** MyCppClass::my2DAllocLinear(int row, int col) {
    int header = row * sizeof(int *);
    int data = row * col * sizeof(int);
    int **rowPtr = (int **)malloc(header + data);
    if (rowPtr == NULL) {
        return NULL;
    }
    int *dataPtr = (int *)(rowPtr + row);
    for (int i=0; i<row; i++) {
        rowPtr[i] = dataPtr + i * col;
    }
    return rowPtr;
}

void MyCppClass::cleanLastLines() {
    if (!this->_lastLines) {
        delete [] this->_lastLines;
    }
}