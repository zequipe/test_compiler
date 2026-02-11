! test_div.f90
program test_div
use iso_fortran_env, only : RP => REAL32

implicit none
real(RP) :: a(14), b(14), c
real(RP) :: d(9), e(9), f
real(RP) :: g(8), h(8), i

a =  [0., 0., 7.E-45, 7.E-45, 0., 5.E-45, 0., 5.E-45, 5.E-45, 0., 0., 0., 0., 5.E-45]
d =  [5.E-45, 0., 5.E-45, 5.E-45, 0., 0., 0., 0., 5.E-45]
g =  [0., 5.E-45, 5.E-45, 0., 0., 0., 0., 5.E-45]

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

end program test_div
