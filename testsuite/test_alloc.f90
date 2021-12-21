module test_alloc_mod
implicit none
private
public :: test_alloc

contains

subroutine test_alloc()
use, non_intrinsic :: linalg_mod, only : trueloc
implicit none

logical :: x(1)
integer :: y(size(x))

x = .false.

y(1:count(x)) = trueloc(x)

print *, x, size(x)
print *, y(1:count(x)), size(y(1:count(x)))

end subroutine test_alloc

end module test_alloc_mod
