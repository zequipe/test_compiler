! $ uname -a && flang --version && flang -O1 test_nan_flang.f90 && ./a.out
! Linux zT 5.4.0-135-generic #152-Ubuntu SMP Wed Nov 23 20:19:22 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
! clang version 7.0.1
! Target: x86_64-pc-linux-gnu
! Thread model: posix
! InstalledDir: /usr/bin
!             NaN  T  T  T  T  T  F
program test_nan_flang
use, intrinsic :: ieee_arithmetic, only : ieee_value, ieee_quiet_nan, ieee_is_nan

implicit none

real :: a

a = ieee_value(a, ieee_quiet_nan)

print *, a, ieee_is_nan(a), a > 0, a >= a, a == a, a <= a, a > a

end program test_nan_flang
