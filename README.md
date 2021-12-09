## Introduction

This is a set of tools for testing the applicability of Fortran compilers in my project
that develops optimization solvers.

## Platform tested

* System: Ubuntu 20.04 (Linux 5.11.15-051115-generic)
* CPU: Intel(R) Core(TM) i7-10610U

## Compilers tested

* [AOCC `flang`](https://developer.amd.com/amd-aocc/) 12.0.0
* [Classical `flang`](https://github.com/flang-compiler/flang) 7.1.0
* [GNU `gfortran`](https://gcc.gnu.org/fortran/) 9.3.0
* [Intel `ifort`](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) 2021.4.0
* [Intel `ifx`](https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/new-features-for-ifx.html) 2021.4.0 Beta
* [NAG `nagfor`](https://www.nag.com/content/nag-fortran-compiler) 7.0
* [NVIDIA `nvfortran`](https://docs.nvidia.com/hpc-sdk/index.html) 20.7
* [Oracle `sunf95`](https://www.oracle.com/tools/developerstudio/downloads/developer-studio-jsp.html) 12.6
* [Absoft Pro Fortran `af95`](https://www.absoft.com) 2022
* [G95 `g95`](https://www.g95.org/downloads.shtml) 0.94
* [Lahey `lf95`](https://lahey.com) L8.10b

As of December 9, 2021, the first eight compilers pass the test.

## Compilers to be tested
* [LFortran](https://lfortran.org)
* [Cray Fortran compiler](https://support.hpe.com/hpesc/public/docDisplay?docId=a00115296en_us&page=OpenMP_Overview.html)
* [IBM Fortran compiler](https://www.ibm.com/products/fortran-compiler-family)
* [NEC Fortran compiler](https://www.nec.com/en/global/solutions/hpc/sx/tools.html)

## Usage

The compilers can be tested using the [`Makefile`](https://github.com/zaikunzhang/test_compiler/blob/master/Makefile) by the commands below. Of course, you need to have the tested compiler installed on your computer, and you may need to edit the [`Makefile`](https://github.com/zaikunzhang/test_compiler/blob/master/Makefile) to fit your platform.


```bash
make dtest  # Test AOCC flang
make ftest  # Test classical flang
make gtest  # Test gfortran
make itest  # Test ifort
make xtest  # Test ifx
make ntest  # Test nagfor
make vtest  # Test nvfortran
make stest  # Test sunf95
make atest  # Test af95
make 9test  # Test g95
make ltest  # Test lf95
```


## Contact

Feel free to contact me if you would like to suggest a compiler or have questions about the test.
See my [homepage](https://www.zhangzk.net) for contact information.
