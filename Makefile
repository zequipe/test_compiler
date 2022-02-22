# This Makefile tests the applicability of compilers for a project of developing optimization solvers.
#
# Coded by Zaikun Zhang (www.zhangzk.net).
#
# Started: Dec 2021
#
# Last Modified: Dec 16, 2021

.SILENT:

.PHONY: test clean

####################################################################################################
# Variables
# Fortran standard to follow. We aim to $(MAKE) the code compatible with F2003, F2008, and F2018.
FS = 03
FSTD = 20$(FS)
# Default options for all the compilers.
FFLAGS = -g -O0
# Common directories.
COMMON = ./common
# Headers.
HEADERS = $(COMMON)/*.h
# Solver directories.
SOLVERS = ./solvers
# Test suite directory
TESTSUITE = ./testsuite

####################################################################################################
# All the tests
test:
	$(MAKE) atest
	$(MAKE) gtest
	$(MAKE) itest
	$(MAKE) ntest
	$(MAKE) stest
	$(MAKE) xtest
	$(MAKE) test_intel  # False positive of unused variable
	$(MAKE) test_flang  # Fail
	$(MAKE) dtest  # Fail: Array, Implied do, Alloc
	$(MAKE) ftest  # Fail: Array, Implied do, Alloc
	$(MAKE) vtest  # Fail: Array, Implied do, Alloc
	$(MAKE) ltest  # Fail
	$(MAKE) 9test  # Fail

####################################################################################################
# Here are the compilers to test. We impose all the options that are actually used in the project.

# G95
9tes%: FC = g95 -std=f$(FSTD) -pedantic -Wall -Wextra \
	-Wimplicit-none -Wline-truncation -Wprecision-loss -Wunused-module-vars -Wunused-vars -Wunset-vars \
	-fimplicit-none -fbounds-check -ftrace=full

# Absoft af95
ifneq ("$(wildcard /etc/debian_version)","")
	AFORT = af95 -no-pie
else
	AFORT = af95
endif
ates%: FC = $(AFORT) -m1 -en -et -Rb -Rc -Rs -Rp

# AMD AOCC Flang
AFLANG := $(shell find /opt/AMD \( -type l -o -type f \) -executable -name flang -print -quit 2> /dev/null || echo AFLANG_NOT_FOUND)
dtes%: FC = $(AFLANG) -std=f$(FSTD) -Wall -Wextra -Minform=warn -Mstandard -Mbounds -Mchkptr -Kieee -ffp-exception-behavior=strict

# LLVM Flang
ftes%: FC = flang -std=f$(FSTD) -Wall -Wextra -Minform=warn -Mstandard -Mbounds -Mchkptr -Kieee

# GNU gfortran
gtes%: FC = gfortran -Wall -Wextra -pedantic -Wampersand -Wconversion  -Wuninitialized \
	-Wmaybe-uninitialized -Wsurprising -Waliasing  -Wimplicit-interface -Wimplicit-procedure \
	-Wintrinsics-std -Wunderflow -Wuse-without-only -Wdo-subscript \
	-Wunused-parameter -fPIC -fimplicit-none -fbacktrace -fcheck=all \
	-finit-real=nan -finit-integer=-9999999
	#-Wrealloc-lhs -Wrealloc-lhs-all

# Intel ifort
ites%: FC = ifort -stand f$(FS) -warn all -check all -debug extended -fimplicit-none \
	-ftrapuv -init=snan,array -fpe0 -fpe-all=0 -assume ieee_fpe_flags \
	-fp-trap=divzero,invalid,overflow,underflow,denormal

# Lahey lf95
ltes%: FC = lf95 --f95 -v95s -v95o -AU --ap --chkglobal --lst --sav --xref --in --info --nswm --trace \
		-w --warn --wo --chk a,e,f,o,s,u,x

# NAG nagfor
ntes%: FC = nagfor -colour=error:red,warn:magenta,info:cyan \
	-I $(TESTSUITE) \
	-f$(FSTD) -info -gline -u -C -C=alias -C=dangling -C=intovf -C=undefined -kind=unique \
	-Warn=constant_coindexing -Warn=subnormal #-Warn=allocation

# NVIDIA nvfortran (aka, pgfortran)
vtes%: FC = nvfortran -C -Wall -Wextra -Minform=warn -Mstandard -Mbounds -Mchkstk -Mchkptr -Kieee -Ktrap=divz,ovf,inv

# Oracle sunf95
stes%: FC = sunf95 -w3 -u -U -ansi -xcheck=%all -C -fnonstd -ftrap=overflow,division,invalid

# Intel ifx
xtes%: FC = ifx -ftrapuv -init=snan,array -fpe0 -fpe-all=0 -assume ieee_fpe_flags \
	-ftrapuv -init=snan,array -fpe0 -fpe-all=0 -assume ieee_fpe_flags \
	-fp-trap=divzero,invalid,overflow,underflow,denorma -no-ftz -fp-model strict

####################################################################################################
# Making a compiler-specific test

test_flang: test_flang.f90
	flang --version && flang test_flang.f90
	$(AFLANG) --version && $(AFLANG) test_flang.f90
	nvfortran --version && nvfortran test_flang.f90

test_intel: test_intel.f90
	ifort --version && ifort -warn all test_intel.f90 && ./a.out
	ifx --version && ifx -warn all test_intel.f90 && ./a.out

%test: test.f90 \
	consts.o info.o debug.o memory.o infnan.o linalg.o rand.o string.o \
	ratio.o resolution.o history.o selectx.o circle.o checkexit.o output.o preproc.o pintrf.o evaluate.o \
	solver_unc.o solver_con.o \
	param.o noise.o prob.o test_solver.o \
	test_implied_do.o test_count.o test_alloc.o test_filt.o \
	test_array12.o test_array3.o \
	coa.o test_coa.o \
	cob.o test_cob.o \
	test_circle.o

	@printf '\n$@ starts!\n\n'
	$(FC) $(FFLAGS) -o $@ test.f90 *.o 2>&1
	@printf '\n===> $@: Compilation completes successfully! <===\n\n'
	./$@
	$(MAKE) clean
	@printf '\n===> $@: Test completes successfully! <===\n\n'

# Compile the Fortran code providing generic modules
%.o: $(COMMON)/%.*90 $(HEADERS)
	$(FC) $(FFLAGS) -c -o $@ $<

# Compile the Fortran code providing solver-specific modules
%.o: $(SOLVERS)/%.f90
	$(FC) $(FFLAGS) -c -o $@ $<

# Compile the Fortran code of the test suite
%.o: $(TESTSUITE)/%.f90
	$(FC) $(FFLAGS) -c -o $@ $<

####################################################################################################
# Cleaning up.
clean:
	rm -f *.o *.mod *.dbg
	rm -f testsuite/*.o testsuite/*.mod testsuite/*.dbg
	rm -f atest* dtest* ftest* gtest* itest* ltest* ntest* stest* vtest* xtest* a.out
