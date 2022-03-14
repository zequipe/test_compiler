module test_uoa_mod
!--------------------------------------------------------------------------------------------------!
! This module tests UOA on a few simple problems.
!
! Coded by Zaikun ZHANG (www.zhangzk.net).
!
! Started: September 2021
!
! Last Modified: Monday, March 14, 2022 PM04:25:05
!--------------------------------------------------------------------------------------------------!

implicit none
private
public :: test_uoa


contains


subroutine test_uoa()

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
real(RP) :: ftarget
real(RP) :: rhobeg
real(RP) :: rhoend
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

end subroutine test_uoa


end module test_uoa_mod

program test

use, non_intrinsic :: test_uoa_mod, only : test_uoa
implicit none

call test_uoa()

end program test
