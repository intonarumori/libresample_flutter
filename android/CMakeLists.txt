cmake_minimum_required(VERSION 3.4.1)

add_library( native_libresample

             SHARED

             ../common/filterkit.c ../common/lrsexport.c ../common/resample.c ../common/resamplesubs.c )
