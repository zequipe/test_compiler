!        This is file : test_nan
! Author= zaikunzhang
! Started at: 16.04.2022
! Last Modified: Thursday, December 08, 2022 PM03:57:01

program test_nan
!use, intrinsic :: iso_fortran_env, only : RP => REAL32  ! Should be tested also
!use, intrinsic :: iso_fortran_env, only : RP => REAL64  ! Should be tested also
use, intrinsic :: iso_fortran_env, only : RP => REAL128
implicit none

real(RP) :: x(0), y
logical :: yleh, ygeh, aygh, yisnan

y = maxval(x)  ! Expected: -HUGE(X); or should it be -INF if the compiler supports INF?
yleh = (y <= huge(y))  ! Expected: T
ygeh = (y >= -huge(y))  ! Expected : T if Y == -HUGE(X), F if Y == -INF
aygh = (abs(y) > huge(y))  ! Expected: F if Y == -HUGE(X), T if Y == -INF
yisnan = (.not. (y <= huge(y) .and. y >= -huge(y))) .and. (.not. abs(y) > huge(y))  ! Expected: F

write (*, *) 'Y =', y, ', Expected', -huge(x)
write (*, *) 'YLEH = ', yleh, ', Expected', .true.
write (*, *) 'YGEH = ', ygeh, ', Expected', .true.
write (*, *) 'AYGH = ', aygh, ', Expected', .false.
write (*, *) 'YISNAN = ', yisnan, ', Expected', .false.

if (yisnan) then
    write (*, *) 'Error: Y is recognized as NaN while it is', y
    stop 1
end if

end program test_nan
