module test_alloc_mod
implicit none
private
public :: test_alloc1, test_alloc2, func1


contains


subroutine test_alloc1
call func2()
call func1()
end subroutine test_alloc1


subroutine test_alloc2
call func1()
end subroutine test_alloc2


subroutine func1()
use, non_intrinsic :: linalg_mod, only : trueloc
implicit none

logical :: x(0)
!integer :: y(1)
integer :: y(2)
!integer :: y(3)
!integer :: y(4)
!integer :: y(5)
!integer :: y(6)
!integer :: y(600)

!x = .false.
y(1:count(x)) = trueloc(x)

end subroutine func1


subroutine func2()
use, non_intrinsic :: consts_mod, only : RP
implicit none

integer, parameter :: n = 9
integer, parameter :: m = 14

integer :: nfilt
logical :: evaluated(n + 1)
real(RP) :: cfilt(2)
real(RP) :: confilt(m, size(cfilt))
real(RP) :: conmat(m, n + 1)
real(RP) :: cval(n + 1)
real(RP) :: ffilt(size(cfilt))
real(RP) :: fval(n + 1)
real(RP) :: sim(n, n + 1)  ! (n, )
real(RP) :: xfilt(n, size(cfilt))

conmat = 0
cval = 0
fval = 0
sim = 0
evaluated = .true.

call initfilt(conmat, 0.0_RP)
end subroutine func2


subroutine initfilt(conmat, ctol)
use, non_intrinsic :: consts_mod, only : RP
implicit none

real(RP), intent(in) :: conmat(:, :)
real(RP), intent(in) :: ctol

end subroutine initfilt


end module test_alloc_mod
