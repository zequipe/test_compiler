program test_bound
!--------------------------------------------------------------------------------------------------!
! This program collects a few tests about the applicability of Fortran compilers on a project of
! developing optimization solvers.
!--------------------------------------------------------------------------------------------------!

use, non_intrinsic :: test_solver_mod, only : test_solver_con
implicit none

print *, 'Test: Constrained solver'
call test_solver_con()
print *, 'Succeed: Constrained solver'

end program test_bound
