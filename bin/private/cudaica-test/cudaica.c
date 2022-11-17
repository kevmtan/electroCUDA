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

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
#include <device.h>
#include <preprocess.h>
#include <postprocess.h>
#include <loader.h>
#include <time.h>
#include <error.h>
#include <infomax.h>
#include <string.h>
#include <math.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>







int main (int argc, char* argv[]) {
	programname = argv[0];
	if (isParam("-s", argv, argc)) {
		char * out = getParam("-s", argv, argc);
		int fd = open(out, O_RDWR | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR);
		if (fd == -1) {
			printf("ERROR: cannot open stdout redirection file: %s\n", out);
			exit(-1);
		}
		if (dup2(fd, STDOUT_FILENO) == -1) {
			printf("ERROR: cannot redirect stdout to file: %s\n", out);
			exit(-1);
		}
		if (dup2(fd, STDERR_FILENO) == -1) {
			fprintf(stderr, "ERROR: cannot redirect stderr to file: %s\n", out);
			exit(-1);
		}
		(void)signal(SIGHUP, SIG_IGN);

	}
#ifdef DEBUG
	printf("Starting CUDAICA v%s with floating point numbers size = %lu bytes and DEBUG level %d\n", GITVERSION, sizeof(real), DEBUG);
#else
	printf("Starting CUDAICA v%s with floating point numbers size = %lu bytes\n", GITVERSION, sizeof(real));
#endif

	if (isParam("-h", argv, argc) || isParam("--help", argv, argc)) {
		help();
		return -1;
	}

	if (isParam("-d", argv, argc)) {
		int device = atoi(getParam("-d", argv, argc));
		selectDevice(device, 1);
	} else {
		selectDevice(0, 1);
	}

	if ( ! isParam("-f", argv, argc)) {
		printf("\nERROR::Script configuration file is mandatory\n\n\n");
		help();
		return -1;
	}



	char *filename = getParam("-f", argv, argc);
	eegdataset_t *dataset = malloc(sizeof(eegdataset_t));
	initDefaultConfig(dataset);
	error err = parseConfig(filename, dataset);
	checkDefaultConfig(dataset);


	if (err == SUCCESS) {
		fprintf(stdout, "====================================\n");
		fprintf(stdout, " Pre processing\n");
		fprintf(stdout, "====================================\n\n");
		printf("Loading dataset...");
		err = loadEEG(dataset);
		if (err != SUCCESS) exit(0);
		err = loadToDevice(dataset);
		if (err != SUCCESS) {
			printf("Cannot load data to device\n");
			return 0;
		}
		printf("Done!\n");

		printf("Centering dataset...");
		time_t start,end;
		time (&start);
		clock_t time1 = clock();
		centerData(dataset);
		printf("Done!\n");
		if (dataset->config.sphering == 1 || dataset->config.sphering == 0) {
			printf("Whitening dataset...");
			whiten(dataset);
			printf("Done!\n");
		}

		printDatasetInfo(dataset);
		clock_t time2 = clock();
		time (&end);
		clock_t dif = difftime (end,start);
		clock_t hour = (dif)/3600;
		clock_t min = (dif/60) % 60;
		clock_t sec = ((dif)) % 60;
		fprintf(stdout, "Elapsed Pre Processing time: %lu tics = %lu h %lu m %lu s\n", time2-time1, hour, min, sec);
		fprintf(stdout, "====================================\n\n");
		fprintf(stdout, "====================================\n");
		fprintf(stdout, " Starting Infomax\n");
		fprintf(stdout, "====================================\n\n");
		infomax(dataset);

		fprintf(stdout, "====================================\n");
		fprintf(stdout, " Post processing\n");
		fprintf(stdout, "====================================\n\n");

		postprocess(dataset);
		saveEEG(dataset);
		freeEEG(dataset);


	}

	return 0;
}
