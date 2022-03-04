module test_ieee_mod
! N.B.:
! 1. This piece of code crashes ifort (IFORT) 2021.5.0 20211109 and ifx (IFORT) 2022.0.0 20211123
! 2. The following code is NOT standard-conforming, because IEEE_VALUE cannot be used in the
! initialization. However, compilers should raise an error instead of crash.

use, intrinsic :: ieee_arithmetic, only : ieee_value, &
    & ieee_quiet_nan, ieee_signaling_nan, ieee_positive_inf, ieee_negative_inf

implicit none

private
public :: ieeenan, ieeenan_q, ieeenan_s, ieeeinf, ieeeinf_p, ieeeinf_n

real, parameter :: ieeenan_q = ieee_value(1.0, ieee_quiet_nan)
real, parameter :: ieeenan_s = ieee_value(1.0, ieee_signaling_nan)
real, parameter :: ieeenan = ieeenan_q

real, parameter :: ieeeinf_p = ieee_value(1.0, ieee_positive_inf)
real, parameter :: ieeeinf_n = ieee_value(1.0, ieee_negative_inf)
real, parameter :: ieeeinf = ieeeinf_p

end module test_ieee_mod
