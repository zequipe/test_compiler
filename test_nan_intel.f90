!--------------------------------------------------------------------------------------------------!
! $ uname -a && ifort --version && ifort test_nan_intel.f90 && ./a.out
! Linux zP 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
! ifort (IFORT) 2021.7.1 20221019
! Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
!
! IEEE_SUPPORT_INF =  T
! A =    1.000000       1.000000       1.000000       1.000000       1.000000
! B =        Infinity
! A / B =             NaN            NaN            NaN            NaN   0.0000000E+00
!--------------------------------------------------------------------------------------------------!

program test
use, intrinsic :: ieee_arithmetic, only : ieee_value, ieee_positive_inf, ieee_support_inf

implicit none

real :: a(5)
real :: b

a = 1.0
b = ieee_value(b, ieee_positive_inf)

write (*, *) 'IEEE_SUPPORT_INF = ', ieee_support_inf(a)
write (*, *) 'A = ', a
write (*, *) 'B = ', b
write (*, *) 'A / B = ', a / b

end program test
