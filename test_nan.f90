!--------------------------------------------------------------------------------------------------!
! $ uname -a && ifort --version && ifort test_nan.f90 && ./a.out
! Linux zP 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
! ifort (IFORT) 2021.7.1 20221019
! Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
!
! A =   6.9849113E+26  2.1425830E+27 -1.4108133E+27 -1.4853050E+26 -2.1667708E+27
! B =        Infinity
! A / B =             NaN            NaN            NaN            NaN   0.0000000E+00
!--------------------------------------------------------------------------------------------------!

program test
implicit none

real, parameter :: a(5) = [6.9849113E+26, 2.1425830E+27, -1.4108133E+27, -1.4853050E+26, -2.1667708E+27]
real :: b

b = 1.0 / tiny(1.0)**2

write (*, *) 'A = ', a
write (*, *) 'B = ', b
write (*, *) 'A / B = ', a / b

end program test
