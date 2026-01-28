!--------------------------------------------------------------------------------------------------!
! Test 1:
! $ uname -a && nvfortran --version && nvfortran -C test_empty_array.f90  && ./a.out
! Linux 6.14.0-37-generic #37~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! nvfortran 26.1-0 64-bit target on x86-64 Linux -tp haswell
! NVIDIA Compilers and Tools
! Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 5)
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 5)
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 6)
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 6)
!   0 inform,   4 warnings,   0 severes, 0 fatal for test_empty_array
! 0: Subscript out of range for array a (test_empty_array.f90: 41)
!     subscript=1, lower bound=1, upper bound=0, dimension=2
!--------------------------------------------------------------------------------------------------!
! Test 2:
! $ uname -a && nvfortran --version && nvfortran -Mbounds test_empty_array.f90  && ./a.out
! Linux 6.14.0-37-generic #37~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! nvfortran 26.1-0 64-bit target on x86-64 Linux -tp haswell
! NVIDIA Compilers and Tools
! Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 5)
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 5)
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 6)
! NVFORTRAN-W-0435-Array declared with zero size (test_empty_array.f90: 6)
!   0 inform,   4 warnings,   0 severes, 0 fatal for test_empty_array
! 0: Subscript out of range for array a (test_empty_array.f90: 41)
!     subscript=1, lower bound=1, upper bound=0, dimension=2
!--------------------------------------------------------------------------------------------------!
program test_empty_array
implicit none

integer :: n, i
real :: A(1, 0)
real :: b(0)
A =  0.0
b = 0.0
n = 0
i = n

write(*, *) "A(:, i+1:n) = ", A(:, i + 1:n)

write(*, *) "b(i+1:n) = ", b(i + 1:n)

end program test_empty_array
