#ifndef MARKSALGORITHM_H
#define MARKSALGORITHM_H

#include <cstdint>

#ifdef _WIN32
    #define DART_EXPORT extern "C" __declspec(dllexport)
#else
    #define DART_EXPORT extern "C"
#endif



DART_EXPORT  const char *marksAlgorithm(
    int16_t src,
    int16_t dest,
    int16_t st,
    int16_t end,
    int16_t est,
    const char* dataPath
);



#endif