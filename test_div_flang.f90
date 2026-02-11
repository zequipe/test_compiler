! test_div_flang.f90
program test_div_flang
use iso_fortran_env, only : RP => REAL32

implicit none

! The code may behave differently depending on the dimension of the array. Try them.
real(RP) :: a(14), b(14), c
a =  [0., 0., 7.E-45, 7.E-45, 0., 5.E-45, 0., 5.E-45, 5.E-45, 0., 0., 0., 0., 5.E-45]

!real(RP) :: a(9), b(9), c
!a =  [5.E-45, 0., 5.E-45, 5.E-45, 0., 0., 0., 0., 5.E-45]
!
!real(RP) :: a(8), b(8), c
!a =  [0., 5.E-45, 5.E-45, 0., 0., 0., 0., 5.E-45]

b =  a / maxval(abs(a))
c =  maxval(abs(a))

print *,  '>>> Dimension = ', size(a)

print *, a/maxval(abs(a)), '|', b
print *, (a/maxval(abs(a)))**2, '|', b**2
print * , '------------------'
print *, a, '|', a/maxval(abs(a)), '|', b
print *, a, '|', (a/maxval(abs(a)))**2, '|', b**2

print * , '=================='

print *, a/c, '|', b
print *, (a/c)**2, '|', b**2
print * , '------------------'
print *, a, '|', a/c, '|', b
print *, a, '|', (a/c)**2, '|', b**2

end program test_div_flang
