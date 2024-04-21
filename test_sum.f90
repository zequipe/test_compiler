!--------------------------------------------------------------------------------------------------!
! $ uname -a && flang --version && flang test_sum.f90 && ./a.out
!Linux 6.5.0-28-generic #29~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Apr  4 14:39:20 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
!flang-new version 19.0.0git (git@github.com:llvm/llvm-project.git 37c175af955f0aeab67e8c553a0a47b2ed0fdba2)
!Target: x86_64-unknown-linux-gnu
!Thread model: posix
! NaN Inf
! sum(x) is  NaN
!Fortran ERROR STOP: code 1
!
!IEEE arithmetic exceptions signaled: INVALID
!--------------------------------------------------------------------------------------------------!
program test_sum
use ieee_arithmetic, only : ieee_value, ieee_positive_inf
use iso_fortran_env, only : RP => REAL128 !REAL64 !REAL32 !REAL16

implicit none
real(RP) :: x(2), y, inf

inf = ieee_value(0.0_RP, ieee_positive_inf)
x = [inf, 0.0_RP]
y = sum(x)

print *, sum(x), x(1) + x(2)
print *, 'sum(x) is ', y

if (.not. y >= inf) then
    error stop 1
end if

end program test_sum
