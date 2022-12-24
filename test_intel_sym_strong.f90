!--------------------------------------------------------------------------------------------------!
! See: https://fortran-lang.discourse.group/t/ifort-ifort-2021-8-0-1-0e-37-1-0e-38-0/4936/6
! The reason is that S(1,7) / 1.0E+38 is calculated as S(1,7) * (1 / 1.0E+38), and 1 / 1.0E+38 is
! calculated as 0 since it is smaller than TINY(1.0) and hence denormal.
!
! Experiment:
! ifort --version && ifort test_intel_sym.f90 && ./a.out
! ifort (IFORT) 2021.8.0 20221119
! Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
! Before: S(1, 7), S(7, 1)  9.9999999E+36  9.9999999E+36
! S is symmetric.
! After: S(1, 7), S(7, 1)  0.0,000000E+00  0.1000000
! S is not symmetric, which is wrong
!--------------------------------------------------------------------------------------------------!

program test

implicit none

real :: S(7, 7)

S = 0.0
S(1, 7) = 1.0E+37
S(7, 1) = S(1, 7)

write (*, *) 'Before: S(1, 7), S(7, 1)', S(1, 7), S(7, 1)

! Is S symmetric?
if (all(abs(S - transpose(S)) <= 0)) then
    write (*, *) 'S is symmetric.'
else
    error stop 'S is not symmetric, which is wrong'
end if

S = S / 1.0E+38

!write (*, *) S
write (*, *) 'After: S(1, 7), S(7, 1)', S(1, 7), S(7, 1)

! Is S symmetric?
if (all(abs(S - transpose(S)) <= 0)) then
    write (*, *) 'S is symmetric.'
else
    error stop 'S is not symmetric, which is wrong'
end if

end program test
