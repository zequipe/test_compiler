!        This is file : test_shape
! Author= zaikunzhang
! Started at: 09.05.2022
! Last Modified: Monday, May 09, 2022 AM08:58:08
! ifort (IFORT) 2021.6.0 20220226 encounters the following error.
!$ ifort - check shape test_shape.f90&&./a.out
!test_shape.f90(11): error #5581: Shape mismatch: The extent of dimension 1 of array A is 1 and the corresponding extent of array <RHS expression> is 2
!a(:, [1, 2]) = a(:, [1, 2]) ! Do nothing ..., but it triggers the error.
!^
!compilation aborted for test_shape.f90 (code 1)

program test_shape
implicit none
integer :: a(1, 2)
a(1, :) = [1, 2]
a(:, 1:2) = a(:, 1:2) ! This line is OK. Benchmark for the erroneous line.
a(:, [1, 2]) = a(:, [1, 2]) ! Do nothing ..., but it triggers the error.
write (*, *) a
end program test_shape
