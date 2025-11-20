// Copyright 2023 The MathWorks, Inc.
#ifndef MW_LOCATION_STRINGIFY_H
#define MW_LOCATION_STRINGIFY_H

#define MW_STRINGIFY(x) #x
#define MW_TOSTRING(x) MW_STRINGIFY(x)
#define MW_AT_LINE MW_TOSTRING(__LINE__)
#define MW_AT_LOCATION __FILE__ "#" MW_AT_LINE

#include <string>
#include <string.h>
#include "nvtx3/nvToolsExt.h"

static void profileLoopStart(const char* loopName, const int line, const int numIter, const char* msgIds = "") {
    std::string msg = "#loop#" + std::string(loopName) + "##" + std::to_string(line) + "#" + std::to_string(numIter);
    if (strlen(msgIds) != 0)
        msg = msg + "#M" + std::string(msgIds);
    nvtxRangePushA(msg.c_str());
}

static void profileLoopEnd() {
    nvtxRangePop();
}

#endif // MW_LOCATION_STRINGIFY_H
