! See https://forums.developer.nvidia.com/t/a-bug-of-nvfortran-21-11/198409
! $ nvfortran --version && nvfortran -C test_implied_do.f90  && ./a.out
!
! nvfortran 26.1-0 64-bit target on x86-64 Linux -tp haswell
! NVIDIA Compilers and Tools
! Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
!  Test: Implied do.
! 0: Subscript out of range for array ffilt (test_implied_do.f90: 38)
!     subscript=2007851435, lower bound=1, upper bound=2, dimension=1
!
! $ nvfortran --version && nvfortran -Mbounds test_implied_do.f90 && ./a.out
!
! nvfortran 26.1-0 64-bit target on x86-64 Linux -tp haswell
! NVIDIA Compilers and Tools
! Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
!  Test: Implied do.
! 0: Subscript out of range for array ffilt (test_implied_do.f90: 30)
!     subscript=0, lower bound=1, upper bound=2, dimension=1


module test_implied_do_mod
implicit none
private
public :: test_implied_do


contains


subroutine test_implied_do()
implicit none
integer :: i
integer :: nfilt
integer, parameter :: maxfilt = 2
logical :: better(maxfilt)
real :: cfilt(maxfilt)
real :: cstrv
real :: f
real :: ffilt(maxfilt)

ffilt = [2.0, 3.0]
cfilt = [3.0, 2.0]
f = 1.0
cstrv = 4.0

nfilt = 0
better(1:nfilt) = [(isbetter([ffilt(i), cfilt(i)], [f, cstrv]), i=1, nfilt)]

nfilt = maxfilt
better(1:nfilt) = [(isbetter([ffilt(i), cfilt(i)], [f, cstrv]), i=1, nfilt)]
if (.not. any(better(1:nfilt))) then
    print *, 'Right'
else
    print *, 'Wrong'
    stop 1
end if
end subroutine test_implied_do


function isbetter(fc1, fc2) result(is_better)
implicit none
real, intent(in) :: fc1(:)
real, intent(in) :: fc2(:)
logical :: is_better

write (*, *) fc1, fc2
is_better = all(fc1 < fc2)
end function isbetter


end module test_implied_do_mod


program test
use, non_intrinsic :: test_implied_do_mod, only : test_implied_do
implicit none

print *, 'Test: Implied do.'
call test_implied_do()
print *, 'Succeed: Implied do.'

end program test
