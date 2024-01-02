! This program demonstrates a bug in the NAG Fortran Compiler 7.1
!
! Author= zaikunzhang
! Started at: 20.06.2023
! Last Modified: Tuesday, January 02, 2024 PM01:19:12
! N.B.: This seems to be related to test_indices.f90.
!----------------------------------------------------------------------------------------------------------------------------------!
! $ Linux zX11 6.2.0-39-generic #40~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 16 10:53:04 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7125
! [NAG Fortran Compiler normal termination]
!  transpose(A(ind, :)) =    1.0000000
!  [transpose(A(ind, :))] =    0.0000000
!  transpose(A(ind, :)) /= [transpose(A(ind, :))]
! STOP: 1
!----------------------------------------------------------------------------------------------------------------------------------!
program test_trans
implicit none

integer, parameter :: n = 1
integer :: ind(n), i, j
real :: A(n, n)

do j = 1, n
    do i = 1, n
        A(i, j) = real(i * j)
    end do
end do

ind = [(i, i=1, n)]

write (*, *) 'transpose(A(ind, :)) = ', transpose(A(ind, :))
write (*, *) '[transpose(A(ind, :))] = ', [transpose(A(ind, :))]

if (any(transpose(A(ind, :)) /= reshape([transpose(A(ind, :))], shape(A)))) then
    write (*, *) 'transpose(A(ind, :)) /= [transpose(A(ind, :))]'
    stop 1
else
    write (*, *) 'transpose(A(ind, :)) == [transpose(A(ind, :))]'
end if

end program test_trans
