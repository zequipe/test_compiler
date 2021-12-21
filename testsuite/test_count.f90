module test_count_mod
implicit none
private
public :: test_count

contains

subroutine test_count()
implicit none

logical :: x(0)

!x = .false.
print *, count(x)

end subroutine test_count

end module test_count_mod
