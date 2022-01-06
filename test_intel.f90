module test_intel_mod
implicit none
private
public :: foo, bar, fun

abstract interface
    function FCN(x) result(f)
    implicit none
    real, intent(in) :: x
    real :: f
    end function FCN
end interface

contains

function foo(fun, n) result(x)
implicit none
procedure(FCN) :: fun
integer, intent(in) :: n
real :: x
real :: fval(n)
fval = 0.0
x = fun(0.0) + sum(fval) + real(n)
end function foo

function bar(fun, n) result(x)
implicit none
procedure(FCN) :: fun
integer, intent(in) :: n
real :: x
x = fun(0.0) + real(n)
end function bar

function fun(x) result(f)
implicit none
real, intent(in) :: x
real :: f
f = x
end function fun

end module test_intel_mod

program test_circle
use, non_intrinsic :: test_intel_mod, only : foo, fun
implicit none
real :: x
x = foo(fun, 1)
print *, x
end program test_circle
