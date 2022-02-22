module test_array3_mod
use, intrinsic :: iso_fortran_env, only : REAL64, REAL128
implicit none
private
public :: array3

contains

subroutine array3()
integer, parameter :: RP = REAL128
integer, parameter :: m = 2
integer, parameter :: n = 200
integer, parameter :: k = 198
real(RP) :: x(m, n)
write (*, *) shape(x(:, k + 1:n))
write (*, *) shape(x(:, 1:k))
write (*, *) shape([x(:, k + 1:n), x(:, 1:k)])
end subroutine array3

end module test_array3_mod
