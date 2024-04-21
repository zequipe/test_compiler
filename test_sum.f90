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
