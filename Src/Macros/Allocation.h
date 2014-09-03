#ifndef ALLOCATION_H
#define ALLOCATION_H

#include <cstdlib>

#define SAFE_DELETE(ptr) do{if(ptr){delete ptr; ptr=NULL;}}while(0)
#define SAFE_DELETE_ARRAY(ptr) do{if(ptr){delete[] ptr; ptr=NULL;}}while(0)

#endif
