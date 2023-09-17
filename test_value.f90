!--------------------------------------------------------------------------------------------------!
! This is an example by Julien Schueller ( https://github.com/jschueller ).
! See https://github.com/flang-compiler/flang/issues/1419.
! Syndrome:
! $ uname -a && flang --version && flang -c test_value.f90
! Linux zX11 6.2.0-32-generic #32~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug 18 10:40:13 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
! flang version 15.0.3
! Target: x86_64-unknown-linux-gnu
! Thread model: posix
! InstalledDir: /home/zaikunzhang/local/flang/bin
! /tmp/test_value-48c7df.ll:10:149: error: expected '('
! define void @mod1_routn1_(i32 %_V_x1.arg, i32 %_V_x2.arg, i32 %_V_x3.arg, i32 %_V_x4.arg, i32 %_V_x5.arg, i32 %_V_x6.arg, %struct.c_funptr.1* byval %_V_fp1.arg) !dbg !20 {
!                                                                                                                                                    ^
! 1 error generated.
!--------------------------------------------------------------------------------------------------!

module mod1
contains

subroutine routn1(x1, x2, x3, x4, x5, x6, fp1)
use, intrinsic :: iso_c_binding, only : C_INT, C_FUNPTR
implicit none
integer(C_INT), intent(in), value :: x1
integer(C_INT), intent(in), value :: x2
integer(C_INT), intent(in), value :: x3
integer(C_INT), intent(in), value :: x4
integer(C_INT), intent(in), value :: x5
integer(C_INT), intent(in), value :: x6
type(C_FUNPTR), intent(in), value :: fp1
end subroutine routn1

end module mod1
