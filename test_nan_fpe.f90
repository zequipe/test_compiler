program test_fpe
use, intrinsic :: ieee_arithmetic, only : ieee_value, ieee_quiet_nan, ieee_is_nan

implicit none

real :: a

a = ieee_value(a, ieee_quiet_nan)

print *, a, ieee_is_nan(a)
print *, a <= 0

end program test_fpe
