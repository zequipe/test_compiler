module test_solver_mod
implicit none
private
public :: test_solver_unc
public :: test_solver_con
public :: test_solver_uoa


contains


subroutine test_solver_unc()

use, non_intrinsic :: consts_mod, only : RP, IK
use, non_intrinsic :: memory_mod, only : safealloc
use, non_intrinsic :: noise_mod, only : noisy, noisy_calfun, orig_calfun
use, non_intrinsic :: prob_mod, only : PNLEN, PROB_T, construct, destruct
use, non_intrinsic :: solver_unc_mod, only : solver_unc

implicit none

character(len=PNLEN) :: probname
character(len=PNLEN) :: probs(100)
integer(IK) :: iprob
integer(IK) :: isol
integer(IK) :: ir
integer(IK) :: n
integer(IK) :: nprobs
integer(IK) :: nsols
integer(IK) :: nr
real(RP) :: Delta0
real(RP) :: f
real(RP), allocatable :: x(:)
type(PROB_T) :: prob


nsols = 3_IK
nprobs = 3_IK
probs(1:nprobs) = ['chebyquad', 'chrosen  ', 'trigsabs ']
nr = 3_IK

do isol = 1, nsols
    do iprob = 1, nprobs
        probname = probs(iprob)
        do ir = 1, nr
            print *, 'Solver No.', isol, '    Unconstrained problem No.', iprob, '    Random run No.', ir
            n = (ir - 1_IK) * 10_IK + 1_IK
            ! Construct the testing problem.
            call construct(prob, probname, n)

            ! Read X0.
            call safealloc(x, prob % n) ! Not all compilers support automatic allocation yet, e.g., Absoft.
            x = noisy(prob % x0)

            ! Read objective/constraints.
            orig_calfun => prob % calfun
            !calfun => noisy_calfun  ! Impose noise to the test problem

            ! Read other data.
            Delta0 = prob % Delta0

            ! Call the solver.
            !call solver_unc(calfun, x, f, Delta0)  ! sunf95 cannot handle this
            call solver_unc(noisy_calfun, x, f, Delta0)

            ! Try modifying PROB.
            prob % x0 = x

            ! Try outputting PROB.
            print *, 'Unconstrained problem solved with X = ', prob % x0
            print *, ''

            ! Clean up.
            ! Destruct the testing problem.
            call destruct(prob)
            deallocate (x)
            !nullify (calfun)
            nullify (orig_calfun)
        end do
    end do
end do

end subroutine test_solver_unc


subroutine test_solver_con()

use, non_intrinsic :: consts_mod, only : RP, IK
use, non_intrinsic :: memory_mod, only : safealloc
use, non_intrinsic :: noise_mod, only : noisy, noisy_calcfc, orig_calcfc
use, non_intrinsic :: prob_mod, only : PNLEN, PROB_T, construct, destruct
use, non_intrinsic :: solver_con_mod, only : solver_con

implicit none

character(len=PNLEN) :: probname
character(len=PNLEN) :: probs(100)
integer(IK) :: iprob
integer(IK) :: ir
integer(IK) :: isol
integer(IK) :: m
integer(IK) :: nprobs
integer(IK) :: nsols
integer(IK) :: nr
real(RP) :: Delta0
real(RP) :: f
real(RP), allocatable :: Aineq(:, :)
real(RP), allocatable :: bineq(:)
real(RP), allocatable :: constr(:)
real(RP), allocatable :: x(:)
type(PROB_T) :: prob


nsols = 3_IK
nprobs = 3_IK
probs(1:nprobs) = ['hexagon', 'chrosen', 'hexagon']
nr = 3_IK

do isol = 1, nsols
    do iprob = 1, nprobs
        probname = probs(iprob)
        do ir = 1, nr
            print *, 'Solver No.', isol, '    Constrained problem No.', iprob, '     Random run No.', ir
            ! Construct the testing problem.
            call construct(prob, probname)

            ! Read M.
            m = prob % m

            ! Read X0.
            call safealloc(x, prob % n) ! Not all compilers support automatic allocation yet, e.g., Absoft.
            x = noisy(prob % x0)

            ! Read objective/constraints.
            orig_calcfc => prob % calcfc
            !calcfc => noisy_calcfc  ! Impose noise to the test problem

            ! Read other data.
            call safealloc(Aineq, int(size(prob % Aineq, 1), IK), int(size(prob % Aineq, 2), IK))
            Aineq = prob % Aineq
            call safealloc(bineq, int(size(prob % bineq), IK))
            bineq = prob % bineq
            Delta0 = prob % Delta0

            ! Call the solver.
            !call solver_con(calcfc, x, f, constr, m, Aineq, bineq, Delta0)  ! sunf95 cannot handle this
            call solver_con(noisy_calcfc, x, f, constr, m, Aineq, bineq, Delta0)

            ! Try modifying PROB.
            prob % x0 = x

            ! Try outputting PROB.
            print *, 'Constrained problem solved with X = ', prob % x0
            print *, ''

            ! Clean up.
            ! Destruct the testing problem.
            call destruct(prob)
            deallocate (x)
            deallocate (Aineq)
            deallocate (bineq)
            !nullify (calcfc)
            nullify (orig_calcfc)
        end do
    end do
end do

end subroutine test_solver_con

subroutine test_solver_uoa()

use, non_intrinsic :: consts_mod, only : RP, IK, TWO, TEN, ZERO, HUGENUM
use, non_intrinsic :: memory_mod, only : safealloc
use, non_intrinsic :: uoa_mod, only : uoa
use, non_intrinsic :: noise_mod, only : noisy, noisy_calfun, orig_calfun
use, non_intrinsic :: param_mod, only : MINDIM_DFT, MAXDIM_DFT, DIMSTRIDE_DFT, NRAND_DFT, RANDSEED_DFT
use, non_intrinsic :: prob_mod, only : PNLEN, PROB_T, construct, destruct
use, non_intrinsic :: string_mod, only : trimstr, istr

implicit none

character(len=PNLEN) :: probname
character(len=PNLEN) :: probs_loc(100)
integer(IK) :: dimstride_loc
integer(IK), parameter :: iprint = 1
integer(IK) :: iprob
integer(IK) :: maxdim_loc
integer(IK), parameter :: maxfun = 2887
integer(IK), parameter :: maxhist = 2420
integer(IK) :: mindim_loc
integer(IK), parameter :: n = 19
integer(IK) :: nprobs
integer(IK), parameter :: npt = 259
integer(IK) :: npt_list(10)
real(RP) :: f
real(RP), parameter :: ftarget = -1.0E10_RP
real(RP), parameter :: rhobeg = 1.0_RP
real(RP), parameter :: rhoend = 1.0E-1_RP
real(RP), allocatable :: fhist(:)
real(RP), allocatable :: x(:)
real(RP), allocatable :: xhist(:, :)
type(PROB_T) :: prob

probname = 'vardim'

call construct(prob, probname, n)  ! Construct the testing problem.

call safealloc(x, n) ! Not all compilers support automatic allocation yet, e.g., Absoft.
x = noisy(prob % x0)
orig_calfun => prob % calfun

call uoa(noisy_calfun, x, f, rhobeg=rhobeg, rhoend=rhoend, npt=npt, maxfun=maxfun, &
    & maxhist=maxhist, fhist=fhist, xhist=xhist, ftarget=ftarget, iprint=iprint)

call destruct(prob)  ! Destruct the testing problem.
! DESTRUCT deallocates allocated arrays/pointers and nullify the pointers. Must be called.
deallocate (x)
nullify (orig_calfun)

end subroutine test_solver_uoa


end module test_solver_mod
