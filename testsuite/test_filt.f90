module test_filt_mod
implicit none
private
public :: test_filt


contains


subroutine test_filt()
use, non_intrinsic :: consts_mod, only : RP, IK
implicit none

integer(IK), parameter :: n = 9
integer(IK), parameter :: m = 14

! Local variables
integer(IK) :: nfilt
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

call initfilt(conmat, 0.0_RP, cval, fval, sim, evaluated, nfilt, cfilt, confilt, ffilt, xfilt)
end subroutine test_filt


subroutine initfilt(conmat, ctol, cval, fval, sim, evaluated, nfilt, cfilt, confilt, ffilt, xfilt)

! Generic modules
use, non_intrinsic :: consts_mod, only : RP, IK, DEBUGGING
use, non_intrinsic :: debug_mod, only : assert
use, non_intrinsic :: infnan_mod, only : is_nan, is_posinf, is_neginf, is_finite
implicit none

! Inputs
real(RP), intent(in) :: conmat(:, :)
real(RP), intent(in) :: ctol
real(RP), intent(in) :: cval(:)
real(RP), intent(in) :: fval(:)
real(RP), intent(in) :: sim(:, :)
logical, intent(in) :: evaluated(:)

! In-outputs
integer(IK), intent(inout) :: nfilt
real(RP), intent(inout) :: cfilt(:)
real(RP), intent(inout) :: confilt(:, :)
real(RP), intent(inout) :: ffilt(:)
real(RP), intent(inout) :: xfilt(:, :)

end subroutine initfilt


end module test_filt_mod
