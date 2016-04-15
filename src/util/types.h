#ifndef __types__h__
#define __types__h__

//XXX: Do not use inttypes on AVR, since all types are mapped to 'int' with __attribute__(...)
//XXX: -> Problem: Type specific aspects do match to any type :-(
/*#include <inttypes.h>

typedef uint64_t UInt64;
typedef uint32_t UInt32;
typedef uint16_t UInt16;
typedef uint8_t UInt8;

typedef int32_t Int32;*/

typedef unsigned long long UInt64;
typedef unsigned long UInt32;
typedef unsigned short UInt16;
typedef unsigned char UInt8;

typedef long Int32;

#endif
