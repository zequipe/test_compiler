!--------------------------------------------------------------------------------------------------!
! $ uname -a && flang --version && flang test_flang_nan.f90 -Ofast && ./a.out
!Linux 6.5.0-28-generic #29~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Apr  4 14:39:20 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
!flang-new version 19.0.0git (git@github.com:llvm/llvm-project.git 37c175af955f0aeab67e8c553a0a47b2ed0fdba2)
!Target: x86_64-unknown-linux-gnu
!Thread model: posix
! T T F F
!Fortran ERROR STOP: code 1

!IEEE arithmetic exceptions signaled: INVALID
!--------------------------------------------------------------------------------------------------!
program test_flang_nan
use ieee_arithmetic, only : ieee_value, ieee_signaling_nan, ieee_quiet_nan
! The problem occurs with REAL64 and REAL32, not REAL16 or REAL128.
use iso_fortran_env, only : RP => REAL32 !REAL64

implicit none
real(RP) :: nan

nan = ieee_value(0.0_RP, ieee_signaling_nan)
! nan = ieee_value(0.0_RP, ieee_quiet_nan)  ! The same problem

print *, nan > 0, nan > 1, nan < 0, nan < 1

if (nan > 0 .or. nan > 1 .or. nan < 0 .or. nan < 1) then
    error stop 1
end if

end program test_flang_nan
