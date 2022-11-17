/*
 *	Copyright (C) 2011, Federico Raimondo (fraimondo@dc.uba.ar)
 *
 *	This file is part of Cudaica.
 *
 *  Cudaica is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 *
 *  Cudaica is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Cudaica.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __DEVICE_H__
#define __DEVICE_H__

#include <builtin_types.h>
#include <loader.h>


#ifdef __cplusplus
extern "C" {
#endif


typedef struct {
	unsigned int 	deviceCount;
	int 			device;
	struct 			cudaDeviceProp deviceProp;
	size_t 			currentFreeMem;
	size_t 			neededReservedMem;
	unsigned int 	nthreads;
} device_t;

void 		recalcFreeMem(size_t elems);
size_t		getFreeMem(void);
natural		getMaxThreads(void);
natural		getMaxBlocks(void);
error		selectDevice(natural, natural);

void 		freeDeviceMem(eegdataset_t *set);
error 		loadToDevice(eegdataset_t *set);
error 		loadWeightsFromDevice(eegdataset_t *set, char* data);
error 		loadSphereFromDevice(eegdataset_t *set, char* data);
error 		loadDataFromDevice(eegdataset_t *set, char* data);
void 		saveFromDevice(eegdataset_t *set);

#ifdef __cplusplus
}
#endif

#endif
