!--------------------------------------------------------------------------------------------------!
!!$ uname -a && aflang --version && aflang test_nint.f90  && ./a.out
!Linux zX13 6.14.0-37-generic #37~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
!AMD clang version 17.0.6 (CLANG: AOCC_5.1.0-Build#1994 2025_12_23)
!Target: x86_64-unknown-linux-gnu
!Thread model: posix
!InstalledDir: /opt/AMD/aocc-compiler-5.1.0/bin
!            0
!--------------------------------------------------------------------------------------------------!
program test_nint
use iso_fortran_env, only: int32, real128
implicit none
write(*,*) 'nint(1.0_real128, int32) =  ', nint(1.0_real128, int32)
if (nint(1.0_real128, int32) /= 1_int32) stop 'error'
end program test_nint
