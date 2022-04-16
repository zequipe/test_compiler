! This is file : test_vec
! Author= zaikunzhang
! Started at: 16.04.2022
! Last Modified: Saturday, April 16, 2022 PM09:29:06
!
! NAG Fortran Compiler Release 7.0 (Yurakucho) Build 7066 fails to compile this file with the
! following error message:
!
! ```
! $ nagfor test_vec.f90
! NAG Fortran Compiler Release 7.0(Yurakucho) Build 7066
! Panic: test_vec.f90: Unexpected contiguous vector subscript ntype 639
! Internal Error -- please report this bug
! ```


module trueloc_mod
implicit none

contains

function trueloc(x) result(loc)
implicit none
logical, intent(in) :: x(:)
integer, allocatable :: loc(:)
integer :: i
allocate (loc(count(x)))
loc = pack([(i, i=1, size(x))], mask=x)
end function trueloc

end module trueloc_mod


program test_vec
use, non_intrinsic :: trueloc_mod, only : trueloc
implicit none
integer, parameter :: n = 2
real :: A(n, n), x(n), y(n)
A = 1.0
x = 1.0
y(1) = 1.0
y(2) = 2.0
write (*, *) x(trueloc(y > 1))
write (*, *) A(trueloc(y > 1), :)
write (*, *) matmul(A(trueloc(y > 1), :), x)
end program test_vec
