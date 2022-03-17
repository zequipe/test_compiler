module solver_unc_mod
implicit none
private
public :: solver_unc


contains


subroutine solver_unc(calfun, x, f, Delta0)
use, non_intrinsic :: consts_mod, only : RP, IK
use, non_intrinsic :: evaluate_mod, only : evaluate
use, non_intrinsic :: rand_mod, only : randn
use, non_intrinsic :: pintrf_mod, only : OBJ

implicit none

! Inputs
procedure(OBJ) :: calfun
real(RP), intent(in) :: Delta0

! Outputs
real(RP), intent(out) :: f

! In-outputs
real(RP), intent(inout) :: x(:)

! Local variables
integer(IK) :: iin
integer(IK) :: iout
integer(IK) :: n
integer(IK) :: nf
real(RP) :: fopt
real(RP) :: xopt(size(x))

n = int(size(x), kind(n))

call evaluate(calfun, x, f)
xopt = x
fopt = f
nf = 1_IK

do iout = 1, 3
    do iin = 1, 3
        nf = nf + 1_IK
        x = x + randn(n) * Delta0 / real(nf, RP)
        call evaluate(calfun, x, f)
        print *, 'Function evaluation No.', nf
        print *, 'Function value', f
        if (f < fopt) then
            xopt = x
            fopt = f
        end if
    end do
end do

x = xopt
f = fopt

end subroutine solver_unc


end module solver_unc_mod
