! This is not a bug, but the result is surprising.
! See https://fortran-lang.discourse.group/t/strange-behavior-of-ifort
! See also test_div.f90
!--------------------------------------------------------------------------------------------------!
! $ ifort --version && ifort test_intel_sym.f90 && ./a.out
!ifort (IFORT) 2021.7.1 20221019
!Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
!
! S is symmetric.
!  0.9999999      2.2718171E-02 -0.3623963      0.9314599     -0.3845887
!  2.2718171E-02  2.2718171E-02 -0.2600954     -0.2734710      0.3337145
! -0.3623963     -0.2600954     -6.2047265E-02 -0.3354508     -2.7986396E-02
!  0.9314599     -0.2734710     -0.3354508      0.2075594     -0.2006450
! -0.3845887      0.3337145     -2.7986394E-02 -0.2006450      0.2823821
!S is not symmetric, which is wrong
!--------------------------------------------------------------------------------------------------!

program test

implicit none

! Why these strange numbers? Because they come from a real project.
real, parameter :: A(25) = &
    & [1.2409463E+22, 2.8192031E+20, -4.4971432E+21, 1.1558917E+22, -4.7725394E+21, &
    & 2.8192031E+20, 2.8192031E+20, -3.2276437E+21, -3.3936284E+21, 4.1412172E+21, &
    & -4.4971432E+21, -3.2276437E+21, -7.6997325E+20, -4.1627641E+21, -3.4729614E+20,&
    & 1.1558917E+22, -3.3936284E+21, -4.1627641E+21, 2.5757004E+21, -2.4898961E+21, &
    & -4.7725394E+21, 4.1412172E+21, -3.4729614E+20, -2.4898961E+21, 3.5042103E+21]

real :: S(5, 5)

S = reshape(A, [5, 5])

! Is S symmetric?
if (all(abs(S - transpose(S)) <= 0)) then
    write (*, *) 'S is symmetric.'
else
    error stop 'S is not symmetric, which is wrong'
end if

! The numbers in S are horrible. Let's scale it.
S = S / maxval(abs(S))

write (*, *) S

! Is S symmetric?
if (all(abs(S - transpose(S)) <= 0)) then
    write (*, *) 'S is symmetric.'
else
    error stop 'S is not symmetric, which is wrong'
end if

end program test
