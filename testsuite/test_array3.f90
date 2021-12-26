program testarray
use, intrinsic :: iso_fortran_env, only : REAL64, REAL128
implicit none
integer, parameter :: RP = REAL128
integer, parameter :: m = 2
integer, parameter :: n = 200
integer, parameter :: k = 198
real(RP) :: x(m, n)
write (*, *) 'Test: Array3 (identical to Array1)'
write (*, *) shape(x(:, k + 1:n))
write (*, *) shape(x(:, 1:k))
write (*, *) shape([x(:, k + 1:n), x(:, 1:k)])
write (*, *) 'Succeed: Array3 (identical to Array1)'
end program testarray
