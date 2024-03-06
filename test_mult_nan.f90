!--------------------------------------------------------------------------------------------------!
! $ uname -a && nagfor test_mult_nan.f90 && ./a.out
! Linux 6.5.0-21-generic #21~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb  9 13:32:52 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7143
! [NAG Fortran Compiler normal termination]
!  A =  NaN NaN
!  WRONG! A is NaN
! ERROR STOP: 1
!--------------------------------------------------------------------------------------------------!
program test_mult_nan

use, intrinsic :: iso_fortran_env, only : RP => real16
use, intrinsic :: ieee_arithmetic, only : ieee_is_nan

implicit none

real(RP) :: A(2)

A = 1.0_RP
A = -1.0_RP * A

write (*, *) 'A = ', A

if (any(ieee_is_nan(A))) then
    write (*, *) 'WRONG! A is NaN'
    error stop 1
end if

end program test_mult_nan
