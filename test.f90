program test
use, non_intrinsic :: test_solver_mod, only : test_solver_unc, test_solver_con
implicit none

call test_solver_unc()

call test_solver_con()

end program test
