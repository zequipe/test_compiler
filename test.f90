program test
use, non_intrinsic :: test_solver_mod, only : test_solver_unc, test_solver_con
use, non_intrinsic :: test_implied_do_mod, only : test_implied_do
use, non_intrinsic :: test_count_mod, only : test_count
use, non_intrinsic :: test_alloc_mod, only : test_alloc
implicit none

print *, 'Test: Count.'
call test_count()
print *, 'Succeed: Count.'

print *, 'Test: Alloc.'
call test_alloc()
print *, 'Succeed: Alloc.'

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
