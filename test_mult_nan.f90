!--------------------------------------------------------------------------------------------------!
! ! On Ubuntu 22.04:
!
! $ uname -a && nagfor -ieee=full test_mult_nan.f90 && ./a.out
! Linux 6.5.0-21-generic #21~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb  9 13:32:52 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7143
! [NAG Fortran Compiler normal termination]
!  A is wrong!
!  A =  NaN NaN
! ERROR STOP: 1
!
! On macOS:
!  % uname -a && nagfor test_mult_nan.f90&& ./a.out
! Darwin 23.3.0 Darwin Kernel Version 23.3.0: Wed Dec 20 21:30:59 PST 2023; root:xnu-10002.81.5~7/RELEASE_ARM64_T6030 arm64
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7144
! [NAG Fortran Compiler normal termination]
!  A =   0.0000  0.0000
!  A is wrong!
! ERROR STOP: 1
!--------------------------------------------------------------------------------------------------!
program test_mult_nan

use, intrinsic :: iso_fortran_env, only : RP => real16
use, intrinsic :: ieee_arithmetic, only : ieee_is_nan

implicit none

real(RP) :: A(2)

A = 1.0_RP
A = -1.0_RP * A

if (any(ieee_is_nan(A)) .or. any(abs(A + 1.0_RP) > 10.0_RP * epsilon(1.0_RP))) then
    write (*, *) 'A = ', A
    write (*, *) 'A is wrong!'
    error stop 1
end if

end program test_mult_nan
