## Introduction

This is a set of tools for testing the applicability of Fortran compilers in my project
that develops optimization solvers.

## Platforms tested

* [鲲鹏计算平台](https://e.huawei.com/cn/products/servers/computing-kunpeng) ([Kunpeng platform with Ubuntu 18.04](https://www.hikunpeng.com/))
* Ubuntu 20.04, Intel(R) Core(TM) i7-10610U
* Ubuntu 20.04, Intel(R) Core(TM) i7-4790 CPU

## Compilers tested

* :negative_squared_cross_mark: [毕昇编译器](https://support.huaweicloud.com/ug-bisheng-kunpengdevps/kunpengbisheng_06_0006.html) ([Bisheng Compiler, based on the Classic flang](https://support.huaweicloud.com/intl/en-us/ug-bisheng-kunpengdevps/kunpengbisheng_06_0001.html)) 1.3.3.b023 (fail: `Array`, `Alloc`, `Implied do`)
* :ballot_box_with_check: [Absoft `af95`](https://www.absoft.com) in Absoft 64-bit Pro Fortran 22.0.2 with patch 3
* :negative_squared_cross_mark: [AOCC `flang`](https://developer.amd.com/amd-aocc/) 4.0.0 (fail: `solve`, `Array`, `Alloc`, `Implied do`)
* :negative_squared_cross_mark: [Classic `flang`](https://github.com/flang-compiler/flang) 15.0.3 (fail: `test_value`, `solve`, `Count`, `Alloc`)
* :negative_squared_cross_mark: [G95 `g95`](https://www.g95.org/downloads.shtml) 0.94 (insufficient support for F03 constructs)
* :negative_squared_cross_mark: [GNU `gfortran`](https://gcc.gnu.org/fortran/) 13.1.0 (fail: `test_eqv`, `test_uninit`)
* :ballot_box_with_check: [Intel `ifort`](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) 2021.9.0
* :ballot_box_with_check: [Intel `ifx`](https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top/language-reference/new-features-for-ifx.html) 2023.1.0
* :negative_squared_cross_mark: [Lahey `lf95`](https://lahey.com) L8.10b (insufficient support for F03 constructs)
* :negative_squared_cross_mark: [NAG `nagfor`](https://www.nag.com/content/nag-fortran-compiler) [Release 7.1](https://monet.nag.co.uk/compiler/r71download/) (Hanzomon) Build 7143 (fail: `test_sym`, `test_isorth`, `test_mult`, `test_abs`)
* :negative_squared_cross_mark: [NVIDIA `nvfortran`](https://docs.nvidia.com/hpc-sdk/index.html) 23.5 (fail: `Alloc`, `Count`, `Implied do`)
* :negative_squared_cross_mark: [Oracle `sunf95`](https://www.oracle.com/tools/developerstudio/downloads/developer-studio-jsp.html) 12.6 (fail: `test_vec`)

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

## Discussions

* [Fortran Discourse](https://fortran-lang.discourse.group):
[Availability and applicability of Fortran compilers for a project](https://fortran-lang.discourse.group/t/availability-and-applicability-of-fortran-compilers-for-a-project)

* Flang GitHub Issue: [flang-new 19.0.0 bug: `nan > 0`, `nan > 1`](https://github.com/llvm/llvm-project/issues/89529)

* Flang GitHub Issue: [flang-new 19.0.0 bug: `sum([Inf, 0.0]) = NaN`, while `Inf + 0.0 = Inf`](https://github.com/llvm/llvm-project/issues/89528)

* Flang GitHub Issue: [False positive: out-bound subscripts](https://github.com/flang-compiler/flang/issues/1238)

* NVIDIA Developer Forums: [Bug in nvfortran 22.3: false positive of out-bound subscripts](https://forums.developer.nvidia.com/t/bug-in-nvfortran-22-3-false-positive-of-out-bound-subscripts)

* NVIDIA Developer Forums: [Bug of nvfortran 22.2-0: array subscript triplet handled wrongly](https://forums.developer.nvidia.com/t/bug-of-nvfortran-22-2-0-array-subscript-triplet-handled-wrongly/)

* Flang GitHub Issue: [Array constructors fail](https://github.com/flang-compiler/flang/issues/1227)

* NVIDIA Developer Forums: [Array constructor fails in `nvfortran 22.3-0`](https://forums.developer.nvidia.com/t/array-constructor-fails-in-nvfortran-22-3-0/)

* Intel Community: [Bug: ifort and ifx crash when compiling a piece of (invalid) code involving ieee_arithmetic](https://community.intel.com/t5/Intel-Fortran-Compiler/Bug-ifort-and-ifx-crash-when-compiling-a-piece-of-invalid-code/m-p/1365757#M160431)

* [Fortran Discourse](https://fortran-lang.discourse.group):
[`Implied do` and array constructor: Strange behavior of `flang` and related compilers](https://fortran-lang.discourse.group/t/implied-do-and-array-constructor-strange-behavior-of-flang-and-related-compilers)
(see also [Flang issue #1200](https://github.com/flang-compiler/flang/issues/1200), [NVIDIA
Developer Forums](https://forums.developer.nvidia.com/t/a-bug-of-nvfortran-21-11), and [AMD
Community](https://community.amd.com/t5/drivers-software/a-bug-in-flang-of-aocc-3-2/m-p/501676#M151151))

* Intel Community: [Bug in `ifort` and `ifx` from oneAPI 2021.2.0 & 2022.0.1: false positive of unused variable](https://community.intel.com/t5/Intel-Fortran-Compiler/Bug-in-ifort-and-ifx-from-oneAPI-2021-2-0-amp-2022-0-1-false/m-p/1348942#M159177)

* Intel Community: [Bug? Strange error raised by `ifort -check shape`](https://community.intel.com/t5/Intel-Fortran-Compiler/Bug-Strange-error-raised-by-ifort-check-shape/m-p/1316901#M157651)

* [Fortran Discourse](https://fortran-lang.discourse.group): [Strange behavior of `ifort`](https://fortran-lang.discourse.group/t/strange-behavior-of-ifort)

* Intel Communities: [A bug of ifort (IFORT) 2021.7.1 20221019](https://community.intel.com/t5/Intel-oneAPI-Base-Toolkit/A-bug-of-ifort-IFORT-2021-7-1-20221019/m-p/1435194#M2603)

* [Fortran Discourse](https://fortran-lang.discourse.group): [`1/inf =?` `ifort` says `NaN`](https://fortran-lang.discourse.group/t/1-inf-ifort-says-nan)

* Flang GitHub Issue: [Flang Binary Release 2019-03-29: `NaN > 0`](https://github.com/flang-compiler/flang/issues/1337)

* Intel Community: [ifort raises a SIGSEGV when evaluating "NaN >= 0"](https://community.intel.com/t5/Intel-Fortran-Compiler/ifort-raises-a-SIGSEGV-when-evaluating-quot-NaN-gt-0-quot/td-p/1440104)

* Fortran Discourse: [Is comparison with `NaN` considered an erroneous arithmetic operation?](https://fortran-lang.discourse.group/t/is-comparison-with-nan-considered-an-erroneous-arithmetic-operation-mwe-with-ifort-and-gfortran)

* Intel Community: [Ifort (IFORT) 2021.8 evaluates `1.0+37 / 1.0E+38` to 0](https://community.intel.com/t5/Intel-Fortran-Compiler/Ifort-IFORT-2021-8-evaluates-1-0E-37-1-0E-38-to-0/m-p/1441059)

* Fortran Discourse: [Ifort (IFORT) 2021.8.0: `1.0E+37 / 1.0E+38 = 0`](https://fortran-lang.discourse.group/t/ifort-ifort-2021-8-0-1-0e-37-1-0e-38-0/4936?u=zaikunzhang)

* Intel Community: [Fail to install oneAPI 2021 on Windows Server 2022](https://community.intel.com/t5/oneAPI-Registration-Download/Fail-to-install-oneAPI-2021-on-Windows-Server-2022/m-p/1445998#M164426)

* Fortran Discourse: [Warning: ‘.str’ may be used uninitialized](https://fortran-lang.discourse.group/t/warning-str-may-be-used-uninitialized)


## Contact

Feel free to contact me if you would like to suggest a compiler or have questions about the test.
See my [homepage](https://www.zhangzk.net) for contact information.
