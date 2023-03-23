from distutils.core import setup, Extension
import argparse
import sys
import numpy as np


class Extender(argparse.Action):
    def __call__(self, parser, namespace, values, option_strings=None):
        # Need None here incase `argparse.SUPPRESS` was supplied for `dest`
        dest = getattr(namespace, self.dest, None)
        if(not hasattr(dest, 'extend') or dest == self.default):
            dest = []
            setattr(namespace, self.dest, dest)
            # if default isn't set to None, this method might be called
            # with the default as `values` for other arguements which
            # share this destination.
            parser.set_defaults(**{self.dest: None})

        try:
            dest.extend(values)
        except ValueError:
            dest.append(values)

parser = argparse.ArgumentParser(description='Build tester bindings')
parser.add_argument('-I', dest='includeparams', type=str, nargs=1,
                    action=Extender, help='Include path')

parser.add_argument('-E', dest='extraparams', type=str, nargs=1,
                    action=Extender, help='Extra parameter')

parser.add_argument('-L', dest='libdirs', type=str, nargs=1, action=Extender,
                    help='Libraries directories')

parser.add_argument('-l', dest='libparams', type=str, nargs=1, action=Extender,
                    help='Libraries names')

oldargs = sys.argv[1:len(sys.argv)]

tosplit = 0
for elem in oldargs:
    if elem.startswith("-l") and len(elem) > 2:
        tosplit = tosplit + 1

newargs = ["" for x in range(len(oldargs)+tosplit)]
i = 0
j = 0
while i < len(oldargs):
    if oldargs[i].startswith("-l") and len(oldargs[i]) > 2:
        newargs[j] = "-l"
        newargs[j+1] = oldargs[i][2:]
        j = j+2
    else:
        newargs[j] = oldargs[i]
        j = j+1
    i = i+1

args = parser.parse_known_args(args=newargs)

if args[0].includeparams is not None:
    newargs = filter(lambda a: a != '-I', newargs)

if args[0].libdirs is not None:
    newargs = filter(lambda a: a != '-L', newargs)

if args[0].libparams is not None:
    newargs = filter(lambda a: a != '-l', newargs)

if args[0].extraparams is not None:
    newargs = filter(lambda a: a != '-E', newargs)

newargs = list(newargs)

includes = []
libs = []
libdirs = []
extra = ['../src/device.o', '../src/error.o', '../src/config.o',
         '../src/loader.o', '../src/common.o', '../src/whitening.o',
         '../src/centering.o', '../src/infomax.o', '../src/postprocess.o']
for elem in args[0].includeparams:
    includes.append(elem)
    newargs.remove(elem)

for elem in args[0].libdirs:
    libdirs.append(elem)
    newargs.remove(elem)

for elem in args[0].libparams:
    libs.append(elem)
    newargs.remove(elem)

for elem in args[0].extraparams:
    extra.append(elem)
    newargs.remove(elem)

extra_compile_args = list(map((lambda x: '-I' + x), includes))

cudaica = Extension('cudaica', sources=['bindings.c'], extra_objects=extra,
                    extra_compile_args=extra_compile_args, library_dirs=libdirs,
                    libraries=libs)


setup(
    name='Cudaica',
    version='1.0',
    description='Cudaica python bindings',
    script_args=newargs,
    include_dirs=[np.get_include()],
    ext_modules=[cudaica])
