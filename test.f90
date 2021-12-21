program test
use, non_intrinsic :: test_solver_mod, only : test_solver_unc, test_solver_con
use, non_intrinsic :: test_implied_do_mod, only : test_implied_do
use, non_intrinsic :: test_count_mod, only : test_count
use, non_intrinsic :: test_alloc_mod, only : test_alloc1, test_alloc2, func1
implicit none

!--------------------------------------------------------------------------------------------------!
!--------------------------------------------------------------------------------!
! Sometimes, but not always, Alloc1/2/3 lead to the following error:
!!Runtime Error: *** Arithmetic exception: Integer divide by zero - aborting
!!common/memory.F90, line 101: Error occurred in MEMORY_MOD:ALLOC_IVECTOR
!!common/linalg.F90, line 2285: Called by LINALG_MOD:TRUELOC
!!testsuite/test_alloc.f90, line 35: Called by TEST_ALLOC_MOD:FUNC1
!!testsuite/test_alloc.f90, line 12: Called by TEST_ALLOC_MOD:TEST_ALLOC1
!!test.f90, line 9: Called by TEST
!--------------------------------------------------------------------------------!
print *, 'Test: Alloc1.'
call test_alloc1()  ! SEGFAULT
print *, 'Succeed: Alloc1.'

print *, 'Test: Alloc2.'  ! Some times it leads to the following Runtime Error, but not always.
call test_alloc2()  ! Runtime Error: common/linalg.F90, line 2286: Unit 6 is not connected
print *, 'Succeed: Alloc2.'

print *, 'Test: Alloc3.'
call func1()
call test_alloc2()  ! Fatal error: glibc detected an invalid stdio handle
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

end program test
