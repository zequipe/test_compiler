module test_count_mod
implicit none
private
public :: test_count

contains

subroutine test_count()
implicit none

logical :: x(0)
logical :: y(0, 1)
logical :: z(1, 0)
logical :: w(1, 1)
logical :: u(1)
integer :: i(100)

x = .false.
print *, count(x)
i(1:count(x)) = 1
y = .false.
print *, count(y)
i(1:count(y)) = 1
z = .false.
print *, count(z)
i(1:count(z)) = 1
w = .false.
!w = .true.
print *, count(w)
i(1:count(w)) = 1
u = .true.
print *, count(u)
i(1:count(u)) = 1


end subroutine test_count

end module test_count_mod
