module test_array_mod
use, intrinsic :: iso_fortran_env, only : REAL32, REAL64, REAL128
implicit none
private
public :: array1, array2

contains

subroutine array1
implicit none
!integer, parameter :: RP = REAL32
integer, parameter :: RP = REAL64
!integer, parameter :: RP = REAL128
integer, parameter :: m = 2
integer, parameter :: n = 200
integer, parameter :: k = 198
real(RP) :: x(m, n)
write (*, *) shape(x(:, k + 1:n))
write (*, *) shape(x(:, 1:k))
write (*, *) shape([x(:, k + 1:n), x(:, 1:k)])
end subroutine array1

subroutine array2
implicit none
!integer, parameter :: RP = REAL32
integer, parameter :: RP = REAL64
!integer, parameter :: RP = REAL128
integer, parameter :: m = 19
integer, parameter :: n = 1687
integer, parameter :: k = 503
real(RP) :: x(m, n)
write (*, *) shape(x(:, k + 1:n))
write (*, *) shape(x(:, 1:k))
write (*, *) shape([x(:, k + 1:n), x(:, 1:k)])
end subroutine array2

end module test_array_mod


program test_array
use, non_intrinsic :: test_array_mod, only : array1, array2
implicit none

write (*, *) 'Test: Array1'
call array1()
write (*, *) 'Succeed: Array1'

write (*, *) 'Test: Array2'
call array2()
write (*, *) 'Succeed: Array2'
end program test_array
