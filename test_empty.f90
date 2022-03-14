!! test_empty.f90
!! $ nvfortran --version && nvfortran -C -O3 test_empty.f90 -o test_empty && ./test_empty
!! nvfortran 22.2-0 64-bit target on x86-64 Linux -tp haswell
!! NVIDIA Compilers and Tools
!! Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
!! 0: Subscript out of range for array a (test_empty.f90: 15)
!!     subscript=4, lower bound=1, upper bound=3, dimension=2
program test_empty

implicit none

integer, parameter :: m = 1
integer, parameter :: n = 3
integer, parameter :: i = n
integer :: j, A(m, n)

do j = 1, n
    A(:, j) = j
end do

A = reshape([A(:, 1:i - 1), A(:, i + 1:n), A(:, i)], shape(A))

write (*, *) A

end program test_empty
