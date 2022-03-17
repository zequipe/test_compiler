program test
!--------------------------------------------------------------------------------------------------!
! This program collects a few tests about the applicability of Fortran compilers on a project of
! developing optimization solvers.
!
! On 20211222:
! NAG nagfor cannot pass test_alloc1/2/3;
! classic flang, AOCC flang, NVIDIA nvfortran cannot pass test_alloc1/2/3 and test_implied_do;
! Absoft af95 cannot compile test_alloc1/2/3 and test_count;
! G95 and Lahey lf95 is incapable of compiling the code due to unsupported F03 constructs;
! gfortran, ifort, ifx, and sunf95 passes all tests.
!--------------------------------------------------------------------------------------------------!

use, non_intrinsic :: test_solver_mod, only : test_solver_unc, test_solver_con, test_solver_uoa
use, non_intrinsic :: test_implied_do_mod, only : test_implied_do
use, non_intrinsic :: test_count_mod, only : test_count
use, non_intrinsic :: test_alloc_mod, only : test_alloc1, test_alloc2, func1
use, non_intrinsic :: test_array12_mod, only : array1, array2
use, non_intrinsic :: test_array3_mod, only : array3
use, non_intrinsic :: test_coa_mod, only : test_coa
use, non_intrinsic :: test_cob_mod, only : test_cob
use, non_intrinsic :: test_circle_mod, only : test_circle
implicit none

print *, 'Test: Array1.'
call array1()
print *, 'Succeed: Array1.'

print *, 'Test: Array2.'
call array2()
print *, 'Succeed: Array2.'

print *, 'Test: Array3.'
call array3()
print *, 'Succeed: Array3.'

print *, 'Test: COA.'
call test_coa()
print *, 'Succeed: COA.'

print *, 'Test: COB.'
call test_cob()
print *, 'Succeed: COB.'

print *, 'Test: CIRCLE.'
call test_circle()
print *, 'Succeed: CIRCLE.'

!--------------------------------------------------------------------------------------------------!
!==========================================================================================!
! Sometimes, but not always, nagfor 7.0 raises the following error when handling Alloc1/2/3:
!!Runtime Error: *** Arithmetic exception: Integer divide by zero - aborting
!!common/memory.F90, line 101: Error occurred in MEMORY_MOD:ALLOC_IVECTOR
!!common/linalg.F90, line 2285: Called by LINALG_MOD:TRUELOC
!!testsuite/test_alloc.f90, line 35: Called by TEST_ALLOC_MOD:FUNC1
!!testsuite/test_alloc.f90, line 12: Called by TEST_ALLOC_MOD:TEST_ALLOC1
!!test.f90, line 9: Called by TEST
!==========================================================================================!
print *, 'Test: Alloc1.'
call test_alloc1()  ! NAG nagor: `SEGFAULT`
print *, 'Succeed: Alloc1.'

print *, 'Test: Alloc2.'  ! Some times nagfor raises the following Runtime Error, but not always.
call test_alloc2()  ! NAG nagfor: `Runtime Error: common/linalg.F90, line 2286: Unit 6 is not connected`
print *, 'Succeed: Alloc2.'

print *, 'Test: Alloc3.'
call func1()
call test_alloc2()  ! NAG nagfor: `Fatal error: glibc detected an invalid stdio handle`
print *, 'Succeed: Alloc3.'
!--------------------------------------------------------------------------------------------------!

print *, 'Test: Count.'
call test_count()
print *, 'Succeed: Count.'

print *, 'Test: Implied do.'
call test_implied_do()
print *, 'Succeed: Implied do.'

print *, 'Test: Unconstrained solver'
call test_solver_unc()
print *, 'Succeed: Unconstrained solver'

print *, 'Test: Constrained solver'
call test_solver_con()
print *, 'Succeed: Constrained solver'

print *, 'Test: UOA'
call test_solver_uoa()
print *, 'Succeed: UOA'

end program test
