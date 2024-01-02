! Author= zaikunzhang
! Started at: 20.06.2023
! Last Modified: Tuesday, January 02, 2024 PM01:19:01
! N.B.: This seems to be related to test_trans.f90.
!
! Result:
!
! $ uname -a && nagfor -V && nagfor test_indices.f90 && ./a.out
! Linux zX10 5.15.0-75-generic #82-Ubuntu SMP Tue Jun 6 23:10:23 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7122
! Product NPL6A71NA for x86-64 Linux
! Copyright 1990-2021 The Numerical Algorithms Group Ltd., Oxford, U.K.
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7122
! [NAG Fortran Compiler normal termination]
!  T
!    4.2200000E+02   2.0380000E+03   1.2550000E+03   2.2500000E+03   2.0880000E+03   1.3050000E+03   2.0320000E+03   1.5270000E+03   1.7270000E+03   1.9270000E+03   2.1270000E+03   2.3270000E+03
!    1.2700000E+02   3.2700000E+02   5.2700000E+02   7.2700000E+02   9.2700000E+02   1.1270000E+03   1.3270000E+03   1.5270000E+03   1.7270000E+03   1.9270000E+03   2.1270000E+03   2.3270000E+03
!  The result is wrong if the above two lines are not identical.
!  B /= C. It is WRONG!
! STOP: 1
!

program test_indices
implicit none

integer, parameter :: m = 200, n = 12
integer :: i
real :: A(m, n)
integer, allocatable :: indices(:)
real, allocatable :: B(:), C(:)
!integer :: indices(m)  ! This is fine
!real :: B(m * n), C(m * n)  ! This is fine

!allocate (indices(m), B(m * n), C(m * n))  ! This does not help

A = reshape(real([(i, i=1, m * n)]), shape(A))

indices = [(i, i=1, m)]
write (*, *) all(A(indices, :) == A)

B = [transpose(A(indices, :))]
!write (*, *) B(1:n)  ! This is fine
write (*, *) B(126 * n + 1:127 * n)
C = [transpose(A)]
!write (*, *) C(1:n)  ! This is fine
write (*, *) C(126 * n + 1:127 * n)

write (*, *) 'The result is wrong if the above two lines are not identical.'

if (all(B == C)) then
    write (*, *) 'B == C. It is correct.'
else
    write (*, *) 'B /= C. It is WRONG!'
    stop 1
end if

end program test_indices
