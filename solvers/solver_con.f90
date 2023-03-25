module solver_con_mod
implicit none
private
public :: solver_con


contains


subroutine solver_con(calcfc, x, f, constr, m, Aineq, bineq, Delta0)
use, non_intrinsic :: consts_mod, only : RP, IK, CTOL_DFT, CWEIGHT_DFT, MAXFILT_DFT
use, non_intrinsic :: evaluate_mod, only : evaluate
use, non_intrinsic :: linalg_mod, only : matprod
use, non_intrinsic :: memory_mod, only : safealloc
use, non_intrinsic :: rand_mod, only : randn
use, non_intrinsic :: selectx_mod, only : savefilt
use, non_intrinsic :: pintrf_mod, only : OBJCON

implicit none

! Inputs
procedure(OBJCON) :: calcfc
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
integer(IK) :: imat
integer(IK) :: iout
integer(IK) :: n
integer(IK) :: nf
integer(IK) :: nfilt
integer(IK), parameter :: maxfilt = MAXFILT_DFT
real(RP) :: cfilt(max(maxfilt, 1_IK))
real(RP) :: confilt(m, size(cfilt))
real(RP) :: conmat(m, size(x) + 1)
real(RP) :: copt
real(RP) :: cstrv
real(RP) :: ffilt(size(cfilt))
real(RP) :: fopt
real(RP) :: xfilt(size(x), size(cfilt))
real(RP) :: xopt(size(x))
real(RP), parameter :: ctol = CTOL_DFT
real(RP), parameter :: cweight = CWEIGHT_DFT

n = int(size(x), kind(n))

call safealloc(constr, m)

call evaluate(calcfc, x, f, constr, cstrv)
cstrv = maxval([cstrv, bineq - matprod(transpose(Aineq), x)])
xopt = x
fopt = f
copt = cstrv
nf = 1_IK
nfilt = 0_IK

do iout = 1, 3
    do iin = 1, 3
        nf = nf + 1_IK
        x = x + randn(n) * Delta0 / real(nf, RP)
        call evaluate(calcfc, x, f, constr, cstrv)
        cstrv = maxval([0.0_RP, -constr, bineq - matprod(transpose(Aineq), x)])
        print *, 'Function evaluation No.', nf
        print *, 'Function value', f
        print *, 'constraint violation', cstrv
        if (f < fopt .and. cstrv <= copt) then
            xopt = x
            fopt = f
            copt = cstrv
        end if

        call savefilt(cstrv, ctol, cweight, f, x, nfilt, cfilt, ffilt, xfilt, constr, confilt)

        imat = mod(nf, n + 1_IK) + 1_IK
        conmat(:, imat) = constr
        call savefilt(cstrv, ctol, cweight, f, x, nfilt, cfilt, ffilt, xfilt, conmat(:, imat), confilt)
    end do
end do

x = xopt
f = fopt
call evaluate(calcfc, x, f, constr, cstrv)


end subroutine solver_con


end module solver_con_mod
