## Introduction

This is a set of tools for testing the applicability of Fortran compilers in my project
that develops optimization solvers.

## Platforms tested

* [鲲鹏计算平台](https://e.huawei.com/cn/products/servers/computing-kunpeng) ([Kunpeng platform with Ubuntu 18.04](https://www.hikunpeng.com/))
* Ubuntu 20.04, Intel(R) Core(TM) i7-10610U
* Ubuntu 20.04, Intel(R) Core(TM) i7-4790 CPU

## Compilers tested

* :negative_squared_cross_mark: [毕昇编译器](https://support.huaweicloud.com/ug-bisheng-kunpengdevps/kunpengbisheng_06_0006.html) ([Bisheng Compiler, based on the Classic flang](https://support.huaweicloud.com/intl/en-us/ug-bisheng-kunpengdevps/kunpengbisheng_06_0001.html)) 1.3.3.b023 (fail: `Array`, `Alloc`, `Implied do`)
* :ballot_box_with_check: [Absoft Pro Fortran `af95`](https://www.absoft.com) 2022 with patch 5
* :negative_squared_cross_mark: [AOCC `flang`](https://developer.amd.com/amd-aocc/) 13.0.0 (fail: `Array`, `Alloc`, `Implied do`)
* :negative_squared_cross_mark: [Classic `flang`](https://github.com/flang-compiler/flang) 7.1.0 (fail: `Array`, `Alloc`, `Implied do`)
* :negative_squared_cross_mark: [G95 `g95`](https://www.g95.org/downloads.shtml) 0.94 (insufficient support for F03 constructs)
* :ballot_box_with_check: [GNU `gfortran`](https://gcc.gnu.org/fortran/) 9.3.0
* :ballot_box_with_check: [Intel `ifort`](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) 2021.5.0
* :ballot_box_with_check: [Intel `ifx`](https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/new-features-for-ifx.html) 2022.0.0
* :negative_squared_cross_mark: [Lahey `lf95`](https://lahey.com) L8.10b (insufficient support for F03 constructs)
* :ballot_box_with_check: [NAG `nagfor`](https://www.nag.com/content/nag-fortran-compiler) [Release 7.0](http://monet.nag.co.uk/compiler/r70download/) (Yurakucho) Build 7066
* :negative_squared_cross_mark: [NVIDIA `nvfortran`](https://docs.nvidia.com/hpc-sdk/index.html) 22.1 (fail: `Array` `Alloc`, `Implied do`)
* :ballot_box_with_check: [Oracle `sunf95`](https://www.oracle.com/tools/developerstudio/downloads/developer-studio-jsp.html) 12.6

## Compilers to be tested

* [Cray Fortran compiler](https://support.hpe.com/hpesc/public/docDisplay?docId=a00115296en_us&page=OpenMP_Overview.html)
* [IBM Fortran compiler](https://www.ibm.com/products/fortran-compiler-family)
* [LFortran](https://lfortran.org)
* [NEC Fortran compiler](https://www.nec.com/en/global/solutions/hpc/sx/tools.html)


## Usage

The compilers can be tested using the [`Makefile`](https://github.com/zaikunzhang/test_compiler/blob/master/Makefile)
by the commands below. Of course, you need to have the tested compiler installed on your computer,
and you may need to edit the [`Makefile`](https://github.com/zaikunzhang/test_compiler/blob/master/Makefile)
to fit your platform.

```bash
make atest  # Test af95
make dtest  # Test AOCC flang
make ftest  # Test classic flang
make 9test  # Test g95
make gtest  # Test gfortran
make itest  # Test ifort
make xtest  # Test ifx
make ltest  # Test lf95
make ntest  # Test nagfor
make vtest  # Test nvfortran
make stest  # Test sunf95
```

## Discussions on [Fortran Discourse](https://fortran-lang.discourse.group)

* [Availability and applicability of Fortran compilers for a project](https://fortran-lang.discourse.group/t/availability-and-applicability-of-fortran-compilers-for-a-project)
* [`Implied do` and array constructor: Strange behavior of `flang` and related compilers](https://fortran-lang.discourse.group/t/implied-do-and-array-constructor-strange-behavior-of-flang-and-related-compilers)
(see also [Flang issue #1200](https://github.com/flang-compiler/flang/issues/1200), [NVIDIA
Developer Forums](https://forums.developer.nvidia.com/t/a-bug-of-nvfortran-21-11), and [AMD
Community](https://community.amd.com/t5/drivers-software/a-bug-in-flang-of-aocc-3-2/m-p/501676#M151151))


## Contact

Feel free to contact me if you would like to suggest a compiler or have questions about the test.
See my [homepage](https://www.zhangzk.net) for contact information.
