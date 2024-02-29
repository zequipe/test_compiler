!--------------------------------------------------------------------------------------------------!
! $ uname -a && nagfor -O1 test_mult.f90 && ./a.out
! Linux 6.5.0-21-generic #21~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb  9 13:32:52 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7143
! [NAG Fortran Compiler normal termination]
!   0.0000  0.0000
!  WRONG! c is zero
! ERROR STOP: 1
!--------------------------------------------------------------------------------------------------!

module test_mod

use iso_fortran_env, only : RP => REAL16
!use iso_fortran_env, only : RP => REAL32
!use iso_fortran_env, only : RP => REAL64
!use iso_fortran_env, only : RP => REAL128
implicit none

contains

function test(a, b, c) result(d)
real(RP), intent(in) :: a
real(RP), intent(in) :: b
real(RP), intent(in) :: c(2)
real(RP) :: d(2)

d = a * b * c

end function test

end module test_mod


program test_mult
use test_mod, only : RP, test
implicit none

real(RP) :: a = 0.99_RP
real(RP) :: b = 0.99_RP
real(RP) :: c(2) = [1.0_RP, 1.0_RP]

write (*, *) test(a, b, c)

if (all(abs(test(a, b, c)) <= 0)) then
    write (*, *) "WRONG! c is zero"
    error stop 1
else
    write (*, *) "RIGHT! c is not zero"
end if

end program test_mult
