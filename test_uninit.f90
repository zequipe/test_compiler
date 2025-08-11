!--------------------------------------------------------------------------------------------------!
! This test illustrates a bug in gfortran 14. With
! ```
! gfortran -Werror -Wuninitialized -fsanitize=undefined -O2 test_uninit.f90
! ```
! or
! ```
! gfortran -Werror -Wmaybe-uninitialized -fsanitize=undefined -O2 test_uninit.f90
! ```
! it fails with:
! ```
! test_uninit.f90:34:19:
!
!    34 | f = [(0.0, i=1, k)]
!       |                   ^
! Error: ‘MEM <real(kind=4)[0:]> [(real(kind=4)[0:] *)_32][0]’ may be used uninitialized [-Werror=maybe-uninitialized]
! f951: all warnings being treated as errors
! ```
! Even with `Wuninitialized`, the error is still `-Werror=maybe-uninitialized`.
! The same error occurs with `-O3`, `-O4`, and `-Ofast`, but not with `-O` `-O0`, or `-O1`.
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
