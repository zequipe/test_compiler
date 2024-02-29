!        This is file : test_isorth.f90
! Author= zaikunzhang
! Started at: 25.02.2024
! Last Modified: Thursday, February 29, 2024 PM12:40:14
! With NAG Fortran Compiler Release 7.1(Hanzomon) Build 7143, REAL16 will lead to an error as
! follows, although REAL32, REAL64, and REAL128 will not.
!--------------------------------------------------------------------------------------------------!
! $ uname -a && nagfor test.f90  && ./a.out
! Linux zX11 6.5.0-21-generic #21~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb  9 13:32:52 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! NAG Fortran Compiler Release 7.1(Hanzomon) Build 7143
! [NAG Fortran Compiler normal termination]
!  A =  -0.7896  0.6143 -0.6143 -0.7896
!  A^T*A =    1.001  0.0000  0.0000   1.001
!  I =    1.000  0.0000  0.0000   1.000
!  |A^T*A - I| =   0.0000  0.0000  0.0000  0.0000
!  max(|A^T*A - I|) =   0.0000
!  tol =   0.9902
!  max(tol, tol * maxval(abs(A))) =   0.9902
!  |A^T*A - I| <= max(tol, tol * maxval(abs(A))) =  T T T T
!  all(|A^T*A - I| <= max(tol, tol * maxval(abs(A)))) =  T
!  is_orth =  F
!  WRONG! The columns of A are not orthonormal up to the tolerance   0.9902
! ERROR STOP: 1
!--------------------------------------------------------------------------------------------------!

module test_mod

use iso_fortran_env, only : RP => REAL16
!use iso_fortran_env, only : RP => REAL32
!use iso_fortran_env, only : RP => REAL64
!use iso_fortran_env, only : RP => REAL128

implicit none

contains

function eye(n) result(x)
!--------------------------------------------------------------------------------------------------!
! EYE returns an order n identity matrix.
!--------------------------------------------------------------------------------------------------!
implicit none

! Inputs
integer, intent(in) :: n
! Outputs
real(RP) :: x(max(n, 0), max(n, 0))
! Local variables
integer :: i

if (size(x, 1) * size(x, 2) > 0) then
    x = 0.0_RP
    do i = 1, int(min(size(x, 1), size(x, 2)), kind(i))
        x(i, i) = 1.0_RP
    end do
end if
end function eye

function isorth(A, tol) result(is_orth)
!--------------------------------------------------------------------------------------------------!
! This function tests whether the matrix A has orthonormal columns up to the tolerance TOL.
!--------------------------------------------------------------------------------------------------!
implicit none

! Inputs
real(RP), intent(in) :: A(:, :)
real(RP), intent(in), optional :: tol
! Outputs
logical :: is_orth
! Local variables
integer :: n
real(RP) :: err(size(A, 2), size(A, 2))

n = int(size(A, 2), kind(n))
err = abs(matmul(transpose(A), A) - eye(n))
is_orth = all(abs(matmul(transpose(A), A) - eye(n)) <= max(tol, tol * maxval(abs(A))))

write (*, *) 'A = ', A
write (*, *) 'A^T*A = ', matmul(transpose(A), A)
write (*, *) 'I = ', eye(n)
write (*, *) '|A^T*A - I| = ', err
write (*, *) 'max(|A^T*A - I|) = ', maxval(err)
write (*, *) 'tol = ', tol
write (*, *) 'max(tol, tol * maxval(abs(A))) = ', max(tol, tol * maxval(abs(A)))
write (*, *) '|A^T*A - I| <= max(tol, tol * maxval(abs(A))) = ', err <= max(tol, tol * maxval(abs(A)))
write (*, *) 'all(|A^T*A - I| <= max(tol, tol * maxval(abs(A)))) = ', all(err <= max(tol, tol * maxval(abs(A))))
write (*, *) 'is_orth = ', is_orth
end function isorth

end module test_mod


program test
use test_mod, only : RP, isorth
implicit none
logical :: is_orth

real(RP) :: A(2, 2) = reshape([-0.7896_RP, 0.6143_RP, -0.6143_RP, -0.7896_RP], [2, 2])
real(RP) :: tol = 0.99_RP

is_orth = isorth(A, tol)

if (is_orth) then
    write (*, *) 'RIGHT! The columns of A are orthonormal up to the tolerance ', tol
else
    write (*, *) 'WRONG! The columns of A are not orthonormal up to the tolerance ', tol
    error stop 1
end if

end program test
