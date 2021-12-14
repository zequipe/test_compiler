module solver_con_mod
implicit none
private
public :: solver_con


contains


subroutine solver_con(calcfc, x, f, constr, m, Aineq, bineq, Delta0)
use, non_intrinsic :: consts_mod, only : RP, IK
use, non_intrinsic :: evaluate_mod, only : evalfc
use, non_intrinsic :: linalg_mod, only : matprod
use, non_intrinsic :: memory_mod, only : safealloc
use, non_intrinsic :: rand_mod, only : randn
use, non_intrinsic :: pintrf_mod, only : FUNCON

implicit none

! Inputs
procedure(FUNCON) :: calcfc
integer(IK), intent(in) :: m
real(RP), intent(in) :: Aineq(:, :)
real(RP), intent(in) :: bineq(:)
real(RP), intent(in) :: Delta0

! Outputs
real(RP), intent(out) :: f
real(RP), allocatable, intent(out) :: constr(:)

! In-outputs
real(RP), intent(inout) :: x(:)

! Local variables
integer(IK) :: iin
integer(IK) :: iout
integer(IK) :: n
integer(IK) :: nf
real(RP) :: copt
real(RP) :: cstrv
real(RP) :: fopt
real(RP) :: xopt(size(x))

n = int(size(x), kind(n))

call safealloc(constr, m)

call evalfc(calcfc, x, f, constr, cstrv)
cstrv = maxval([cstrv, bineq - matprod(Aineq, x)])
xopt = x
fopt = f
copt = cstrv
nf = 1_IK

do iout = 1, 5
    do iin = 1, 5
        nf = nf + 1_IK
        x = x + randn(n) * Delta0 / real(nf, RP)
        call evalfc(calcfc, x, f, constr, cstrv)
        cstrv = maxval([0.0_RP, -constr, bineq - matprod(Aineq, x)])
        print *, 'Function evaluation No.', nf
        print *, 'Function value', f
        print *, 'constraint violation', cstrv
        if (f < fopt .and. cstrv <= copt) then
            xopt = x
            fopt = f
            copt = cstrv
        end if
    end do
end do

x = xopt
f = fopt
call evalfc(calcfc, x, f, constr, cstrv)


end subroutine solver_con


end module solver_con_mod
