!        This is file : test_def
! Author= zaikunzhang
! Started at: 03.06.2022
! Last Modified: Friday, June 03, 2022 PM01:18:42
!
! NAG Fortran Compiler Release 7.0(Yurakucho) Build 7074 raises the following false positive error.
!--------------------------------------------------------------------------------------------------!
! $ nagfor -C=undefined test_def.f90  && ./a.out
! NAG Fortran Compiler Release 7.0(Yurakucho) Build 7074
! [NAG Fortran Compiler normal termination]
! Runtime Error: test_def.f90, line 37: Reference to undefined variable Z(2,:)
! Program terminated by fatal error
! Abandon (core dumped)
!--------------------------------------------------------------------------------------------------!


module test_def_mod

implicit none
private
public :: test_def


contains


subroutine test_def()
implicit none
real(kind(0.0D0)) :: z(2, 1)
call ztest(z)
end subroutine test_def

subroutine ztest(z)
implicit none
real(kind(0.0D0)), intent(inout) :: z(:, :)
z = 0.0D0
z([1, 2], :) = z([2, 1], :)
end subroutine ztest


end module test_def_mod


program test
use :: test_def_mod, only:test_def
implicit none
call test_def()
end program test
