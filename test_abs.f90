!--------------------------------------------------------------------------------------------------!
! $ uname -a && nagfor -ieee=full test_abs.f90  && ./a.out
! Linux 6.5.0-21-generic #21~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb  9 13:32:52 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7143
! [NAG Fortran Compiler normal termination]
!  NaN NaN NaN NaN
!  NaN NaN NaN NaN
!  NaN NaN NaN NaN
!  NaN NaN NaN NaN
!   0.0000  0.0000  0.0000  0.0000
!   0.0000  0.0000  0.0000  0.0000
!  T T T T
!  T T T T
!   0.0000  0.0000  0.0000  0.0000
!   0.0000  0.0000  0.0000  0.0000
!  T T T T
!  T T T T
!  Test failed
! ERROR STOP: 1
!--------------------------------------------------------------------------------------------------!

program test

use, intrinsic :: iso_fortran_env, only : RP => real16
use, intrinsic :: ieee_arithmetic, only : ieee_value, ieee_quiet_nan, ieee_is_nan

implicit none

real(RP) :: NAN_RP, A(2, 2), B(2, 2), E1(2, 2), E2(2, 2)

NAN_RP = ieee_value(0.0_RP, ieee_quiet_nan)

A = reshape([-0.0_RP, 0.0_RP, 0.0_RP, 0.0_RP], [2, 2])
B = reshape([NAN_RP, NAN_RP, NAN_RP, NAN_RP], [2, 2])
E1 = abs(matmul(B, A) - A)
E2 = abs(matmul(B, A) - B)

write (*, *) matmul(B, A)
write (*, *) abs(matmul(B, A))
write (*, *) matmul(B, A) - A
write (*, *) matmul(B, A) - B
write (*, *) abs(matmul(B, A) - A)
write (*, *) abs(matmul(B, A) - B)
write (*, *) ieee_is_nan(abs(matmul(B, A) - A))
write (*, *) ieee_is_nan(abs(matmul(B, A) - B))
write (*, *) E1
write (*, *) E2
write (*, *) E1 <= 0
write (*, *) E2 <= 0

if (.not. all(ieee_is_nan(E1)) .or. .not. all(ieee_is_nan(E2))) then
    write (*, *) 'Test failed'
    error stop 1
else
    write (*, *) 'Test passed'
end if

end program test
