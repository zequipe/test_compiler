!--------------------------------------------------------------------------------------------------!
! ifort --version && ifort test_intel_sym.f90 && ./a.out
! ifort (IFORT) 2021.8.0 20221119
! Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
! Before: S(1, 7), S(7, 1) -1.7633055E+37 -1.7633055E+37
! Before: S(1, 7), S(7, 1)  9.9999999E+36  9.9999999E+36
! S is symmetric.
! After: S(1, 7), S(7, 1)  0.0000000E+00  0.1000000
! S is not symmetric, which is wrong
!--------------------------------------------------------------------------------------------------!

program test

implicit none

! Why these strange numbers? Because they come from a real project.
real, parameter :: A(49) = &
& [-1.2450638E+36, 3.2670646E+36, -1.9066904E+36, 6.2253192E+35, 2.4581355E+36, 6.2253192E+35, 1.0E+37, &
& 3.2670646E+36, -2.2380216E+36, 4.7253489E+36, 3.2670646E+36, 5.1026695E+36, 3.2670646E+36, -1.4988522E+37, &
& -1.9066904E+36, 4.7253489E+36, 2.2412790E+36, -1.9066904E+36, -3.7422960E+36, -1.9066904E+36, 1.6348895E+37, &
& 6.2253192E+35, 3.2670646E+36, -1.9066904E+36, -1.2450638E+36, 2.4581355E+36, 6.2253192E+35, -1.7633055E+37, &
& 2.4581355E+36, 5.1026695E+36, -3.7422960E+36, 2.4581355E+36, -2.7723962E+36, 2.4581355E+36, -1.5797452E+37, &
& 6.2253192E+35, 3.2670646E+36, -1.9066904E+36, 6.2253192E+35, 2.4581355E+36, -1.2450638E+36, -1.7633055E+37, &
& 1.0E+37, -1.4988522E+37, 1.6348895E+37, -1.7633055E+37, -1.5797452E+37, -1.7633055E+37, 4.8741171E+37]

real :: S(7, 7)

S = reshape(A, [7, 7])

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
