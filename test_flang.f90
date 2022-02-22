program test_flang
implicit none

integer, parameter :: m = 2
integer, parameter :: n = 100
integer, parameter :: k = 50
real :: x(m, n)

write (*, *) [x(:, k + 1:n), x(:, 1:k)]

end program test_flang
