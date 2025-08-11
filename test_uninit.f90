!--------------------------------------------------------------------------------------------------!
! This test illustrates a bug in gfortran 14. With
! ```
! gfortran -Werror -Wmaybe-uninitialized -fsanitize=undefined -O2 test_uninit.f90
! ```
! it fails with:
! test_uninit.f90:26:19:
!
!    26 | f = [(0.0, i=1, k)]
!       |                   ^
! Error: ‘MEM <real(kind=4)[0:]> [(real(kind=4)[0:] *)_32][0]’ may be used uninitialized [-Werror=maybe-uninitialized]
! f951: all warnings being treated as errors
!--------------------------------------------------------------------------------------------------!
module test_mod
implicit none
private
public :: test

contains

subroutine test(k)
implicit none
integer(8), intent(in) :: k
integer(8) :: i
real :: f(k)
f = [(0.0, i=1, k)]
f = 0.0
end subroutine test
end module test_mod

program test_program
end program test_program
