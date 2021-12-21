module test_count_mod
implicit none
private
public :: test_count

contains

subroutine test_count()
implicit none

logical :: x(0)
integer :: y(size(x))

!x = .false.
y(1:count(x)) = 1

end subroutine test_count

end module test_count_mod
