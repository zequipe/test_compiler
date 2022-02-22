module test_circle_mod
implicit none
private
public :: test_circle

contains

subroutine test_circle()
use, non_intrinsic :: consts_mod, only : RP, IK
use, non_intrinsic :: circle_mod, only : circle_min
implicit none

real(RP) :: x
real(RP) :: args(2)

args = 0.0_RP

print *, 'Test: Circle.'
x = circle_min(cfun, args, 10_IK)
print *, 'X = ', x
print *, 'Succeed: Circle.'
end subroutine test_circle


function cfun(x, args) result(f)
use, non_intrinsic :: consts_mod, only : RP
implicit none

real(RP), intent(in) :: x
real(RP), intent(in) :: args(:)
real(RP) :: f

f = x * sum(args)

end function cfun

end module test_circle_mod
