! This is not a bug, but the result is surprising.
! See https://fortran-lang.discourse.group/t/strange-behavior-of-ifort
! See also test_intel_sym.f90.
!--------------------------------------------------------------------------------------------------!
! $ uname -a && ifort --version && ifort test_div.f90 && ./a.out
! Linux zP 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
!
! ifort (IFORT) 2021.7.1 20221019
! Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
!
!  x =   3.7037041E-02  3.7037041E-02  3.7037041E-02  3.7037041E-02  3.7037045E-02
!  i =            1 x(1) == x(i)? T
! 111101000101111011010000100111 111101000101111011010000100111
!  i =            2 x(1) == x(i)? T
! 111101000101111011010000100111 111101000101111011010000100111
!  i =            3 x(1) == x(i)? T
! 111101000101111011010000100111 111101000101111011010000100111
!  i =            4 x(1) == x(i)? T
! 111101000101111011010000100111 111101000101111011010000100111
!  i =            5 x(1) == x(i)? F
! 111101000101111011010000100111 111101000101111011010000101000
!  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  !!!!!! x(1) is different from x(i) !!!!!!
!  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!--------------------------------------------------------------------------------------------------!

program test
implicit none

integer :: i
real :: x(5)
x = 1.0  ! All elements of x are set to the same value.
print *, 'Before division, x = ', x
print *, 'All entries of x are identical?', all(x == x(1))
x = x / 3.0  ! OR: x = x / x(1)
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
