! See: https://fortran-lang.discourse.group/t/ifort-ifort-2021-8-0-1-0e-37-1-0e-38-0/4936/6
! The reason is that x(5) / 1.0E+38 is calculated as x(5) * (1 / 1.0E+38), and 1 / 1.0E+38 is
! calculated as 0 since it is smaller than TINY(1.0) and hence denormal.
!
! Experiment:
! $ uname -a && ifort --version && ifort test_div_strong.f90 && ./a.out
! Linux zP 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
!
! ifort (IFORT) 2021.7.1 20221019
! Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
!
! Before division, x =   9.9999999E+36  9.9999999E+36  9.9999999E+36 9.9999999E+36  9.9999999E+36
! All entries of x are identical? T
! After division, x =   0.0000000E+00  0.0000000E+00  0.0000000E+00 0.0000000E+00  0.1000000
!  i =            1 x(1) == x(i)? T
! 0 0
!  i =            2 x(1) == x(i)? T
! 0 0
!  i =            3 x(1) == x(i)? T
! 0 0
!  i =            4 x(1) == x(i)? T
! 0 0
!  i =            5 x(1) == x(i)? F
! 0 111101110011001100110011001101
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! !!!!!!!!!!! Surprise! x(1) is different from x(i) !!!!!!!!!
! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!--------------------------------------------------------------------------------------------------!

program test
implicit none

integer :: i
real :: x(5)
x = 1.0E37  ! All elements of x are set to the same value.
print *, 'Before division, x = ', x
print *, 'All entries of x are identical?', all(x == x(1))
x = x / 1.0E38
print *, 'After division, x = ', x
do i = 1, size(x)
    print *, 'i = ', i, 'x(1) == x(i)?', x(1) == x(i)

    print "(*(b0,1x))", x(1), x(i)

    if (x(1) /= x(i)) then
        print *, ''
        print *, '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        print *, '!!!!!!!!!!! Surprise! x(1) is different from x(i) !!!!!!!!!'
        print *, '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        print *, ''
    end if
end do

end program test
