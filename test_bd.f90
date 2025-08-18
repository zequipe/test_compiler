! This program illustrates a bug of nvfortran 25.7-0.
!--------------------------------------------------------------------------------------------------!
! Test 1.
! $ uname -a && nvfortran --version && nvfortran -C -O2 test_bd.f90 && ./a.out
! Linux 6.14.0-27-generic #27~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 22 17:38:49 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! nvfortran 25.7-0 64-bit target on x86-64 Linux -tp haswell
! NVIDIA Compilers and Tools
! Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
!  A(:, i+1:n) =
! 0: Subscript out of range for array a (test_bd.f90: 34)
!     subscript=3, lower bound=1, upper bound=2, dimension=2
!--------------------------------------------------------------------------------------------------!
! Test 2.
! $ uname -a && nvfortran --version && nvfortran -Mbounds -O2 test_bd.f90 && ./a.out
! Linux zX13 6.14.0-27-generic #27~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 22 17:38:49 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

! nvfortran 25.7-0 64-bit target on x86-64 Linux -tp haswell
! NVIDIA Compilers and Tools
! Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
!  A(:, i+1:n) =
! 0: Subscript out of range for array a (test_bd.f90: 34)
!     subscript=3, lower bound=1, upper bound=2, dimension=2
!--------------------------------------------------------------------------------------------------!

program test_bd
implicit none

integer :: n, i
real :: A(2, 2), Anew(4)
A =  0.0
n = size(A, 2)
i = n
write(*, *) "A(:, i+1:n) = ", A(:, i + 1:n)
Anew = [A(:, 1:i - 1), A(:, i + 1:n), A(:, i)]
write(*, *) "Anew = ", Anew

end program test_bd
