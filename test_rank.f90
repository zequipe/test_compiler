! This is file : test_rank
! Author= zaikunzhang
! Started at: 16.04.2022
! Last Modified: Tuesday, May 03, 2022 AM12:09:17
!
! NAG Fortran Compiler Release 7.0 (Yurakucho) Build 7066 fails to compile this file with the
! following error message:
!
! ```
!$ nagfor - C test_rank.f90&&./a.out
!NAG Fortran Compiler Release 7.0(Yurakucho) Build 7066
![NAG Fortran Compiler normal termination]
!Runtime Error: test_rank.f90, line 46: Vector subscript for rank 1 of A has extent 2 instead of 0
!Program terminated by fatal error
!Aborted
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


program test_rank
use, non_intrinsic :: trueloc_mod, only : trueloc
implicit none
integer, parameter :: n = 2
real :: A(n, n), y(n)
A = 1.0
y(1) = 1.0
y(2) = 2.0
A([1, 2], 1:0) = A([2, 1], 1:0)  ! No problem
A([1, 2], 2) = A([2, 1], 2)  ! No problem
A([1, 2], trueloc(y < 1)) = A([2, 1], trueloc(y < 1))
A([1, 2], trueloc(y > 1)) = A([2, 1], trueloc(y > 1))
end program test_rank
