module cob_mod

implicit none
private
public :: cob


contains


subroutine cob(calcfc, x, f, &
    & cstrv, constr, &
    & m, f0, constr0, &
    & nf, rhobeg, rhoend, ftarget, ctol, maxfun, iprint, &
    & xhist, fhist, conhist, chist, maxhist, maxfilt, info)

use, non_intrinsic :: consts_mod, only : DEBUGGING
use, non_intrinsic :: consts_mod, only : MAXFUN_DIM_DFT, MAXFILT_DFT
use, non_intrinsic :: consts_mod, only : RHOBEG_DFT, RHOEND_DFT, CTOL_DFT, FTARGET_DFT, IPRINT_DFT
use, non_intrinsic :: consts_mod, only : RP, IK, ZERO, TEN, TENTH, EPS, MSGLEN
use, non_intrinsic :: debug_mod, only : assert, errstop, warning
!use, non_intrinsic :: evaluate_mod, only : eval_count, f_x0, constr_x0
use, non_intrinsic :: history_mod, only : prehist
use, non_intrinsic :: infnan_mod, only : is_nan, is_inf, is_finite, is_neginf, is_posinf
use, non_intrinsic :: memory_mod, only : safealloc
use, non_intrinsic :: pintrf_mod, only : OBJCON
use, non_intrinsic :: selectx_mod, only : isbetter
use, non_intrinsic :: preproc_mod, only : preproc

! Solver-specific modules

implicit none

! Compulsory arguments
procedure(OBJCON) :: calcfc
real(RP), intent(inout) :: x(:)
real(RP), intent(out) :: f

! Optional inputs
integer(IK), intent(in), optional :: iprint
integer(IK), intent(in), optional :: m
integer(IK), intent(in), optional :: maxfilt
integer(IK), intent(in), optional :: maxfun
integer(IK), intent(in), optional :: maxhist
real(RP), intent(in), target, optional :: constr0(:)
real(RP), intent(in), optional :: ctol
real(RP), intent(in), target, optional :: f0
real(RP), intent(in), optional :: ftarget
real(RP), intent(in), optional :: rhobeg
real(RP), intent(in), optional :: rhoend

! Optional outputs
integer(IK), intent(out), optional :: info
integer(IK), intent(out), optional :: nf
real(RP), intent(out), allocatable, optional :: chist(:)
real(RP), intent(out), allocatable, optional :: conhist(:, :)
real(RP), intent(out), allocatable, optional :: constr(:)
real(RP), intent(out), allocatable, optional :: fhist(:)
real(RP), intent(out), allocatable, optional :: xhist(:, :)
real(RP), intent(out), optional :: cstrv

! Local variables
character(len=*), parameter :: ifmt = '(I0)'  ! I0: use the minimum number of digits needed to print
character(len=*), parameter :: solver = 'COB'
character(len=*), parameter :: srname = 'COB'
character(len=MSGLEN) :: wmsg
integer(IK) :: i
integer(IK) :: info_loc
integer(IK) :: iprint_loc
integer(IK) :: m_loc
integer(IK) :: maxfilt_loc
integer(IK) :: maxfun_loc
integer(IK) :: maxhist_loc
integer(IK) :: n
integer(IK) :: nf_loc
integer(IK) :: nhist
real(RP) :: cstrv_loc
real(RP) :: ctol_loc
real(RP) :: ftarget_loc
real(RP) :: rhobeg_loc
real(RP) :: rhoend_loc
real(RP), allocatable :: chist_loc(:)
real(RP), allocatable :: conhist_loc(:, :)
real(RP), allocatable :: fhist_loc(:)
real(RP), allocatable :: xhist_loc(:, :)
real(RP), allocatable :: v(:)
real(RP), allocatable :: con(:)
real(RP), allocatable :: c(:)

write (*, *) 'v'
call safealloc(v, 0_IK)
write (*, *) 'con'
call safealloc(con, 0_IK)
write (*, *) 'c'

end subroutine cob


end module cob_mod
