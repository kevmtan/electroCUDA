// Copyright 2020 The MathWorks, Inc.

#ifndef MW_CUSOLVER_UTILS_HPP
#define MW_CUSOLVER_UTILS_HPP

#include "cusolverDn.h"

void cusolverEnsureInitialization();

void cusolverEnsureDestruction();

void cusolverDestroyWorkspace();

void cusolverInitWorkspace();

cusolverDnHandle_t getCuSolverGlobalHandle();

int* getCuSolverWorkspaceReq();

void* getCuSolverWorkspaceBuff();

int getCuSolverWorkspaceSize();

int getCuSolverWorkspaceTypeSize();

void setCuSolverWorkspaceTypeSize(int input);

#endif // #ifndef MW_CUSOLVER_UTILS_HPP
