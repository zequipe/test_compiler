module solve_mod
implicit none
private
public :: solve


contains


function solve(A, b) result(x)
implicit none
real, intent(in) :: A(:, :), b(:)
real :: x(size(A, 2))
integer :: i, n

n = size(b)

do i = n, 1, -1
    x(i) = (b(i) - inprod(A(i, i + 1:n), x(i + 1:n))) / A(i, i)
    !x(i) = (b(i) - dot_product(A(i, i + 1:n), x(i + 1:n))) / A(i, i)  ! No problem will arise
end do

end function solve


function inprod(x, y) result(z)
real, intent(in) :: x(:), y(:)
real :: z
z = dot_product(x, y)
end function inprod

end module solve_mod


program test_solve
use, non_intrinsic :: solve_mod, only : solve
implicit none

real :: A(1, 1), b(1)

A = 1.0
b = 1.0

write (*, *) solve(A, b)

end program test_solve
