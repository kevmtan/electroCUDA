#include <Python.h>

#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION

#include <config.h>
#include <device.h>
#include <loader.h>
#include <error.h>
#include <preprocess.h>
#include <infomax.h>
#include <postprocess.h>
#include <numpy/arrayobject.h>



static PyObject *cudaicaError;

char errbuffer [2048];

static PyObject *
cudaica_selectDevice(PyObject *self, PyObject *args)
{
	unsigned int device;
	unsigned int verbose = 1;

	if (!PyArg_ParseTuple(args, "I|I", &device, &verbose)) {
		printf("No device selected, using default: %i\n", device);

	}

	selectDevice(device, verbose);
	return PyLong_FromUnsignedLong(0);
}


void freeDataset(PyObject * dataset) {
	freeEEG(PyCapsule_GetPointer(dataset, NULL));

}

static PyObject *
cudaica_initDefaultConfig(PyObject *self, PyObject *args)
{
	eegdataset_t * dataset = malloc(sizeof(eegdataset_t));
	initDefaultConfig(dataset);

	PyObject * retorno = PyCapsule_New(dataset, NULL, &freeDataset);

	return retorno;
}

static PyObject *
cudaica_printConfig(PyObject *self, PyObject *args)
{
	PyObject * dataset;

	if (!PyArg_ParseTuple(args, "O", &dataset)) {
		PyErr_SetString(cudaicaError, "No dataset specified.");

	}

	printConfig(PyCapsule_GetPointer(dataset, NULL));
	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_checkDefaultConfig(PyObject *self, PyObject *args)
{
	PyObject * dataset;

	if (!PyArg_ParseTuple(args, "O", &dataset)) {
		PyErr_SetString(cudaicaError, "No dataset specified.");

	}

	checkDefaultConfig(PyCapsule_GetPointer(dataset, NULL));
	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_debugData(PyObject *self, PyObject *args)
{
	PyObject * data;

	if (!PyArg_ParseTuple(args, "O", &data)) {
		PyErr_SetString(cudaicaError, "No data specified.");
		return NULL;
	}
	int i = 0;
	PyArrayObject * ndarray = (PyArrayObject*) data;

	printf("nd %d\n", PyArray_NDIM(ndarray));
	printf("dimensions ");
	for (i = 0; i < PyArray_NDIM(ndarray); i++) {
		printf(" %d ", (int)PyArray_DIM(ndarray, i));
	}
	printf("\nstrides ");
	for (i = 0; i < PyArray_NDIM(ndarray); i++) {
		printf(" %d ", (int)PyArray_STRIDE(ndarray, i));
	}
	printf("\ndata at %p\n", (void*)PyArray_DATA(ndarray));


	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_setIntParameter(PyObject *self, PyObject *args)
{
	PyObject * dataset;
	char * param;
	natural value;

#ifdef USELONG
	if (!PyArg_ParseTuple(args, "OsL", &dataset, &param, &value)) {
#else
	if (!PyArg_ParseTuple(args, "Osi", &dataset, &param, &value)) {
#endif
		PyErr_SetString(cudaicaError, "No parameters specified.");
		return NULL;
	}

	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);

	if (strcmp("nchannels", param) == 0) {
		set->config.nchannels = value;
	} else if (strcmp("nsamples", param) == 0) {
		set->config.nsamples = value;
	} else if (strcmp("maxsteps", param) == 0) {
		set->config.maxsteps = value;
	} else if (strcmp("extended", param) == 0) {
		set->config.extended = value;
	} else if (strcmp("verbose", param) == 0) {
		set->config.verbose = value;
	} else if (strcmp("biasing", param) == 0) {
		set->config.biasing = value;
	} else if (strcmp("blocksize", param) == 0) {
		set->config.block = value;
	} else if (strcmp("seed", param) == 0) {
		set->config.seed = value;
	} else {
		sprintf(errbuffer, "Unknown parameter %s specified.", param);
		PyErr_SetString(cudaicaError, errbuffer);
		return NULL;
	}
	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_setRealParameter(PyObject *self, PyObject *args)
{
	PyObject * dataset;
	char * param;
	real value;

#ifdef USESINGLE
	if (!PyArg_ParseTuple(args, "Osf", &dataset, &param, &value)) {
#else
	if (!PyArg_ParseTuple(args, "Osd", &dataset, &param, &value)) {
#endif
		PyErr_SetString(cudaicaError, "No parameters specified.");
		return NULL;
	}

	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);

	if (strcmp("lrate", param) == 0) {
		set->config.lrate = value;
	} else if (strcmp("nochange", param) == 0) {
		set->config.nochange = value;
	} else if (strcmp("annealstep", param) == 0) {
		set->config.annealstep = value;
	} else if (strcmp("annealdeg", param) == 0) {
		set->config.annealdeg = value;
	} else {
		sprintf(errbuffer, "Unknown parameter %s specified.", param);
		PyErr_SetString(cudaicaError, errbuffer);
		return NULL;
	}
	return PyLong_FromUnsignedLong(0);
}


static int sbool2int(char * item) {
	int result = 0;
	if (strcmp(item, "on") == 0) {
		result = 1;
	} else if (strcmp(item, "off") == 0) {
		result = 0;
	} else if (strcmp(item, "on\n") == 0) {
		result = 1;
	} else if (strcmp(item, "off\n") == 0) {
		result = 0;
	} else if (strcmp(item, "none") == 0) {
		result = 2;
	} else if (strcmp(item, "none\n") == 0) {
		result = 2;
	} else {
		result = -1;
	}
	return result;

}

static PyObject *
cudaica_setStringParameter(PyObject *self, PyObject *args)
{
	PyObject * dataset;
	char * param;
	char * value;

	if (!PyArg_ParseTuple(args, "Oss", &dataset, &param, &value)) {
		PyErr_SetString(cudaicaError, "No parameters specified.");
		return NULL;
	}

	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);
	int ivalue = sbool2int(value);
	if (ivalue == -1) {
		sprintf(errbuffer, "Unknown bool value %s specified.", value);
		PyErr_SetString(cudaicaError, errbuffer);
		return NULL;
	}
	if (strcmp("sphering", param) == 0) {
		set->config.sphering = ivalue;
	} else {
		sprintf(errbuffer, "Unknown parameter %s specified.", param);
		PyErr_SetString(cudaicaError, errbuffer);
		return NULL;
	}
	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_transfer2DDataTo(PyObject *self, PyObject *args)
{
	PyObject * data;
	PyObject * dataset;

	if (!PyArg_ParseTuple(args, "OO", &data, &dataset)) {
		PyErr_SetString(cudaicaError, "No data specified.");
		return NULL;
	}
	int i = 0;
	PyArrayObject * ndarray = (PyArrayObject*) data;
	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);

	natural nchannels = set->config.nchannels;
	natural nsamples = set->config.nsamples;


	if (set->data != NULL) free(set->data);

	set->data = malloc(nchannels * nsamples * sizeof(real));



	int chandim = -1;

	if (PyArray_NDIM(ndarray) != 2) {
		PyErr_SetString(cudaicaError, "This function loads 2dimension only.");
		return NULL;
	}


	for (i = 0; i < PyArray_NDIM(ndarray); i++) {
		printf("Dimension %d (%d - %d strides)\n", i, (int)PyArray_DIM(ndarray, i), (int)PyArray_STRIDE(ndarray, i));
		if ((int)PyArray_DIM(ndarray, i) == nchannels) {
			chandim = i;
			printf("Found! (%d) \n",i);
		}
	}
	if (chandim == -1) {
		PyErr_SetString(cudaicaError, "No dimension matches nchannels.");

		return NULL;
	}

	if ((int)PyArray_STRIDE(ndarray, chandim) != 8) {
		printf("Main dimension (%d) has %d strides. Data arrangement needed.\n", chandim, (int)PyArray_STRIDE(ndarray, chandim));
		int chan = 0;
		int sample = 0;
		real * realdata = set->data;
		real * realsrc = (real*)PyArray_DATA(ndarray);
		int chanoffset = (int)PyArray_STRIDE(ndarray, chandim)/8;
		//int sampleoffset = ndarray->strides[chandim == 0 ? 1 : 0]/8;

		for (chan = 0; chan < nchannels; chan++) {
			for (sample = 0; sample < nsamples; sample++) {
				realdata[chan + sample * nchannels] = realsrc[sample + chan * chanoffset];
			}
		}
	} else {
		memcpy((char*)set->data, (char*)PyArray_DATA(ndarray), nsamples*nchannels*sizeof(real));
	}

	set->nchannels = nchannels;
	set->nsamples = nsamples;

	return PyLong_FromUnsignedLong(0);
}



static PyObject *
cudaica_transferWeightsFrom(PyObject *self, PyObject *args)
{
	PyObject * dataset;

	if (!PyArg_ParseTuple(args, "O", &dataset)) {
		PyErr_SetString(cudaicaError, "No data specified.");
		return NULL;
	}



	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);

	natural nchannels = set->nchannels;

	npy_intp dims[2];
	dims[0] = nchannels;
	dims[1] = nchannels;

	PyArrayObject * ndarray = (PyArrayObject*) PyArray_ZEROS(2, dims, NPY_DOUBLE, 0);

	error err = loadWeightsFromDevice(set, PyArray_DATA(ndarray));

	if (err != 0) {
		char * fmt = "Error loading weights from device %d ";
		sprintf(errbuffer, fmt, err);
		PyErr_SetString(cudaicaError, errbuffer);
	}
	return (PyObject *)ndarray;
}

static PyObject *
cudaica_transferDataFrom(PyObject *self, PyObject *args)
{
	PyObject * dataset;

	if (!PyArg_ParseTuple(args, "O", &dataset)) {
		PyErr_SetString(cudaicaError, "No data specified.");
		return NULL;
	}



	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);

	natural nchannels = set->nchannels;
	natural nsamples = set->nsamples;

	npy_intp dims[2];
	dims[0] = nchannels;
	dims[1] = nsamples;

	PyArrayObject * ndarray = (PyArrayObject*) PyArray_ZEROS(2, dims, NPY_DOUBLE, 0);

	error err = loadDataFromDevice(set, PyArray_DATA(ndarray));

	if (err != 0) {
		char * fmt = "Error loading data from device %d ";
		sprintf(errbuffer, fmt, err);
		PyErr_SetString(cudaicaError, errbuffer);
	}
	return (PyObject *)ndarray;
}

static PyObject *
cudaica_transferSphereFrom(PyObject *self, PyObject *args)
{
	PyObject * dataset;

	if (!PyArg_ParseTuple(args, "O", &dataset)) {
		PyErr_SetString(cudaicaError, "No data specified.");
		return NULL;
	}

	eegdataset_t * set = PyCapsule_GetPointer(dataset, NULL);

	natural nchannels = set->nchannels;

	npy_intp dims[2];

	dims[0] = nchannels;
	dims[1] = nchannels;

	PyArrayObject * ndarray = (PyArrayObject*) PyArray_ZEROS(2, dims, NPY_DOUBLE, 0);

	error err = loadSphereFromDevice(set, PyArray_DATA(ndarray));
	if (err != 0) {
		char * fmt = "Error loading weights from device %d ";
		sprintf(errbuffer, fmt, err);
		PyErr_SetString(cudaicaError, errbuffer);
	}
	return (PyObject *) ndarray;
}




static PyObject *
cudaica_preprocess(PyObject *self, PyObject *args)
{
	PyObject * set;
	error err;
	if (!PyArg_ParseTuple(args, "O", &set)) {
		PyErr_SetString(cudaicaError, "No dataset specified.");
		return NULL;
	}
	eegdataset_t * dataset = PyCapsule_GetPointer(set, NULL);
	if (dataset->config.verbose != 0) {
		fprintf(stdout, "====================================\n");
		fprintf(stdout, " Pre processing\n");
		fprintf(stdout, "====================================\n\n");

	}
	printf("Loading dataset...");
	err = loadToDevice(dataset);
	if (err != SUCCESS) {
		PyErr_SetString(cudaicaError,"Cannot load data to device\n");
		return NULL;
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
	if (dataset->config.verbose != 0) {
		printDatasetInfo(dataset);
	}
	clock_t time2 = clock();
	time (&end);
	clock_t dif = difftime (end,start);
	clock_t hour = (dif)/3600;
	clock_t min = (dif/60) % 60;
	clock_t sec = ((dif)) % 60;
	fprintf(stdout, "Elapsed Pre Processing time: %lu tics = %lu h %lu m %lu s\n", time2-time1, hour, min, sec);
	if (dataset->config.verbose != 0) {
		fprintf(stdout, "====================================\n\n");
	}

	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_process(PyObject *self, PyObject *args)
{
	PyObject * set;
	if (!PyArg_ParseTuple(args, "O", &set)) {
		PyErr_SetString(cudaicaError, "No dataset specified.");
		return NULL;
	}
	eegdataset_t * dataset = PyCapsule_GetPointer(set, NULL);
	if (dataset->config.verbose != 0) {
		fprintf(stdout, "====================================\n");
		fprintf(stdout, " Starting Infomax\n");
		fprintf(stdout, "====================================\n\n");
	}
	infomax(dataset);

	return PyLong_FromUnsignedLong(0);
}

static PyObject *
cudaica_postprocess(PyObject *self, PyObject *args)
{
	PyObject * set;
	if (!PyArg_ParseTuple(args, "O", &set)) {
		PyErr_SetString(cudaicaError, "No dataset specified.");
		return NULL;
	}
	eegdataset_t * dataset = PyCapsule_GetPointer(set, NULL);
	if (dataset->config.verbose != 0) {
		fprintf(stdout, "====================================\n");
		fprintf(stdout, " Post processing\n");
		fprintf(stdout, "====================================\n\n");
	}

	postprocess(dataset);

	return PyLong_FromUnsignedLong(0);
}

//~
//~ static PyObject *
//~ bindings_listarfiltros(PyObject *self, PyObject *args)
//~ {
	//~ printf("Listando filtros\n");
	//~ PyObject *pylist, *item;
    //~ int i;
    //~ pylist = PyList_New(NFILTROS);
    //~ if (pylist != NULL) {
      //~ for (i=0; i<NFILTROS; i++) {
        //~ item = PyString_FromString(filtros[i]);
        //~ PyList_SET_ITEM(pylist, i, item);
      //~ }
    //~ }
	//~ return Py_BuildValue("O", pylist);
//~ }
//~
//~ static PyObject *
//~ bindings_distancias(PyObject *self, PyObject *args)
//~ {
	//~ const char *archivo1;
	//~ const char *archivo2;
//~
	//~ if (!PyArg_ParseTuple(args, "ss", &archivo1, &archivo2)) {
		//~ PyErr_SetString(bindingsError, "Archivos no especifidados");
		//~ return NULL;
	//~ }
//~
	//~
	//~ distancias * resultado = bindiff(archivo1, archivo2);
	//~ printf("Distancias entre %s y %s = %lu %lu %lu %f\n", archivo1, archivo2, resultado->pixeles, resultado->sumdif, resultado->maxdif, resultado->radio);
	//~
	//~ PyObject * retorno = PyDict_New();
	//~
	//~ PyDict_SetItemString(retorno, "pixeles", PyLong_FromUnsignedLong(resultado->pixeles));
	//~ PyDict_SetItemString(retorno, "difpixeles", PyLong_FromUnsignedLong(resultado->difpixeles));
	//~ PyDict_SetItemString(retorno, "maxdif", PyLong_FromUnsignedLong(resultado->maxdif));
	//~ PyDict_SetItemString(retorno, "sumdif", PyLong_FromUnsignedLong(resultado->sumdif));
	//~ PyDict_SetItemString(retorno, "radio", PyFloat_FromDouble(resultado->radio));
	//~ PyDict_SetItemString(retorno, "porcentaje", PyFloat_FromDouble(resultado->porcentaje));
	//~
	//~ freedist(resultado);
	//~ return retorno;
//~ }




static PyMethodDef CudaicaMethods[] = {
	{"selectDevice",  cudaica_selectDevice, METH_VARARGS, "Initialize CUDA device."},
	{"initDefaultConfig",  cudaica_initDefaultConfig, METH_VARARGS, "Initialize default configuration."},
	{"checkDefaultConfig",  cudaica_checkDefaultConfig, METH_VARARGS, "Check default configuration."},
	{"debugData",  cudaica_debugData, METH_VARARGS, "Debug ndarray."},
	{"transfer2DDataTo",  cudaica_transfer2DDataTo, METH_VARARGS, "Transfer 2D data to Cudaica dataset."},
	{"transferWeightsFrom",  cudaica_transferWeightsFrom, METH_VARARGS, "Transfer weights data from Cudaica."},
	{"transferSphereFrom",  cudaica_transferSphereFrom, METH_VARARGS, "Transfer sphere data from Cudaica."},
	{"transferDataFrom",  cudaica_transferDataFrom, METH_VARARGS, "Transfer data from Cudaica."},

	{"preprocess",  cudaica_preprocess, METH_VARARGS, "Center and Whiten data."},
	{"process",  cudaica_process, METH_VARARGS, "Run infomax."},
	{"postprocess",  cudaica_postprocess, METH_VARARGS, "Post process data."},
	{"printConfig",  cudaica_printConfig, METH_VARARGS, "Print configuration parameters."},
	{"setIntParameter",  cudaica_setIntParameter, METH_VARARGS, "Set configuration parameters."},
	{"setStringParameter",  cudaica_setStringParameter, METH_VARARGS, "Set configuration parameters."},
	{"setRealParameter",  cudaica_setRealParameter, METH_VARARGS, "Set configuration parameters."},
	{NULL, NULL, 0, NULL}
};


#if PY_MAJOR_VERSION == 3
static struct PyModuleDef cudaicamodule = {
   PyModuleDef_HEAD_INIT,
   "cudaica",   /* name of module */
   NULL, /* module documentation, may be NULL */
   -1,       /* size of per-interpreter state of the module,
                or -1 if the module keeps state in global variables. */
   CudaicaMethods
};

PyMODINIT_FUNC PyInit_cudaica(void) {
	PyObject *m;
	m = PyModule_Create(&cudaicamodule);
	if (m == NULL)
		return NULL;
#else
PyMODINIT_FUNC
initcudaica(void)
{
	PyObject *m;

	m = Py_InitModule("cudaica", CudaicaMethods);
	if (m == NULL)
		return;
#endif
	cudaicaError = PyErr_NewException("cudaica.error", NULL, NULL);
	Py_INCREF(cudaicaError);
	PyModule_AddObject(m, "error", cudaicaError);
	import_array();
#if PY_MAJOR_VERSION == 3
	return m;
#endif
}
