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
 
#ifndef __LOADER_H__
#define __LOADER_H__

#include <config.h>

#ifdef __cplusplus
extern "C" {
#endif
void 			printDatasetInfo(eegdataset_t* dataset);
error 			freeEEG(eegdataset_t *dataset);
error 			loadEEG(eegdataset_t *dataset);
error			saveEEG(eegdataset_t *dataset);
#ifdef __cplusplus
}
#endif


#endif
