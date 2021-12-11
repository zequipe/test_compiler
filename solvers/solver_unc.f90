module solver_unc_mod
implicit none
private
public :: solver_unc


contains


subroutine solver_unc(calfun, x, f, Delta0)
use, non_intrinsic :: consts_mod, only : RP, IK
use, non_intrinsic :: evaluate_mod, only : evalf
use, non_intrinsic :: rand_mod, only : randn
use, non_intrinsic :: pintrf_mod, only : FUN

implicit none

! Inputs
procedure(FUN) :: calfun
real(RP), intent(in) :: Delta0

! Outputs
real(RP), intent(out) :: f

! In-outputs
real(RP), intent(inout) :: x(:)

! Local variables
integer(IK) :: k
integer(IK) :: n
real(RP) :: fopt
real(RP) :: xopt(size(x))

n = int(size(x), kind(n))

call evalf(calfun, x, f)
xopt = x
fopt = f

do k = 1, 10
    x = x + randn(n) * Delta0 / real(k, RP)
    call evalf(calfun, x, f)
    print *, 'Function evaluation No.', k
    print *, 'Function value', f
    if (f < fopt) then
        xopt = x
        fopt = f
    end if
end do

x = xopt
f = fopt

end subroutine solver_unc


end module solver_unc_mod
